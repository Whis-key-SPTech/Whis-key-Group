var database = require("../database/config");

function listarSensores(idDestilaria, horas) {
  var instrucaoSql = `   
    SELECT 
        rua,
        nome_localidade,
        MAX(temperatura) as max_temp,
        MIN(temperatura) as min_temp,
        MAX(umidade) as max_umid,
        MIN(umidade) as min_umid,
        (SELECT temperatura FROM registro WHERE fk_sensor = v.id_sensor ORDER BY dt_coleta DESC LIMIT 1) as temperatura_atual,
        (SELECT umidade FROM registro WHERE fk_sensor = v.id_sensor ORDER BY dt_coleta DESC LIMIT 1) as umidade_atual
    FROM vw_dados_sensor_completo v
    WHERE 
        v.fk_destilaria = ${idDestilaria} 
        AND  TIMESTAMP(dt_coleta, hr_coleta) >= DATE_SUB(NOW(), INTERVAL ${horas}
     HOUR)

    GROUP BY 
        v.id_sensor, v.rua, v.nome_localidade;
`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


function maiorIntervalo(idDestilaria, horas) {
  var instrucaoSql = `
    SELECT 
    l.nome_localidade,
    TIMESTAMPDIFF(HOUR, MAX(TIMESTAMP(r.dt_coleta, r.hr_coleta)), NOW()) as horas_consecutivas
    FROM registro r
    JOIN sensor s ON r.fk_sensor = s.id_sensor
    LEFT JOIN localidade_sensor l ON s.fk_idLocalidadeSensor = l.id_localidadeSensor
    JOIN destilaria d ON s.fk_destilaria = d.id_destilaria
    WHERE 
        r.temperatura BETWEEN 18 AND 25
        AND 
        TIMESTAMP(dt_coleta, hr_coleta) >= DATE_SUB(NOW(), INTERVAL ${horas}
        HOUR)
        and id_destilaria = ${idDestilaria}
    GROUP BY s.id_sensor, l.nome_localidade
    ORDER BY horas_consecutivas DESC limit 1 ;

`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function eficiencia(idDestilaria, horas) {
  var instrucaoSql = `
       SELECT 
      round(SUM(case when r.temperatura BETWEEN 18 AND 25 then 1 else 0 end) / count( r.temperatura) * 100 )as eficiencia
      FROM registro r
      JOIN sensor s ON r.fk_sensor = s.id_sensor
      LEFT JOIN localidade_sensor l ON s.fk_idLocalidadeSensor = l.id_localidadeSensor
      JOIN destilaria d ON s.fk_destilaria = d.id_destilaria
      WHERE 
     TIMESTAMP(r.dt_coleta, r.hr_coleta) >= DATE_SUB(NOW(), INTERVAL ${horas}
     HOUR)
     and id_destilaria = ${idDestilaria};

`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


function buscarSensor(id) {
  var instrucaoSql = `SELECT * FROM sensor where id_sensor = '${id}';`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}



// DashBoard Sensor Específico 

var database = require("../database/config");
 function tempAtual(idSensor) {
    var instrucaoSql = `
    SELECT temperatura, dt_coleta, hr_coleta
    FROM registro
    WHERE fk_sensor = ${idSensor}      
    ORDER BY dt_coleta DESC, hr_coleta DESC
    LIMIT 1;`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
  }

function eficienciaSensor(idDestilaria, horas) {
  var instrucaoSql = `
    SELECT
      ROUND(
        SUM(CASE
              WHEN r.temperatura BETWEEN 18 AND 25
              THEN 1 ELSE 0
            END)
        / COUNT(r.temperatura) * 100
      ) AS eficiencia
    FROM registro r
    JOIN sensor s ON r.fk_sensor = s.id_sensor
    JOIN destilaria d ON s.fk_destilaria = d.id_destilaria
    LEFT JOIN localidade_sensor l ON s.fk_idLocalidadeSensor = l.id_localidadeSensor
    WHERE
      TIMESTAMP(r.dt_coleta, r.hr_coleta) >= DATE_SUB(NOW(), INTERVAL ${horas} HOUR)
      AND d.id_destilaria = ${idDestilaria}
      AND s.id_sensor = 1;
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}
  function umidAtual(idSensor) {
    var instrucaoSql = `
    SELECT umidade, dt_coleta, hr_coleta
    FROM registro
    WHERE fk_sensor = ${idSensor}      
    ORDER BY dt_coleta DESC, hr_coleta DESC
    LIMIT 1;`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
  }

  function contagemStatus(idSensor) {
    var instrucaoSql = `
        SELECT
            SUM(CASE
                  WHEN temperatura >= 30
                    OR temperatura <= 10
                    OR umidade >= 80
                    OR umidade <= 20
                THEN 1 ELSE 0 END) AS grave,

            SUM(CASE
                  WHEN (temperatura >= 25 AND temperatura < 30)
                    OR (temperatura > 10 AND temperatura <= 20)
                    OR (umidade >= 60 AND umidade < 80)
                    OR (umidade > 20 AND umidade <= 40)
                THEN 1 ELSE 0 END) AS atencao,

            SUM(CASE
                  WHEN temperatura > 20 AND temperatura < 25
                    AND umidade > 40 AND umidade < 60
                THEN 1 ELSE 0 END) AS estavel
        FROM registro
        WHERE fk_sensor = ${idSensor};
    `;

    console.log("Executando SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
  }

  function tempHistorico(idSensor) {
    var instrucaoSql = `
          SELECT
              temperatura,
              umidade,
              dt_coleta,
              hr_coleta,
              TIMESTAMP(dt_coleta, hr_coleta) AS data_hora
          FROM registro
          WHERE
              fk_sensor = ${idSensor}
              AND TIMESTAMP(dt_coleta, hr_coleta) >= DATE_SUB(NOW(), INTERVAL 6 HOUR)
          ORDER BY data_hora ASC;
      `;

      console.log("Executando a instrução SQL: \n" + instrucaoSql);
      return database.executar(instrucaoSql);
  }


module.exports = {
  listarSensores,
  buscarSensor,
  eficiencia,
  maiorIntervalo,
  tempAtual,
  umidAtual,
  contagemStatus,
  tempHistorico,
  eficienciaSensor
}
