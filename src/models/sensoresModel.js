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



module.exports = {
  listarSensores,
  buscarSensor,
  eficiencia,
  maiorIntervalo
}
