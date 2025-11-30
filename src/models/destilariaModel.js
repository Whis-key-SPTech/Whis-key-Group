var database = require("../database/config");

function listarDestilaria(horas) {
  var instrucaoSql = `
         SELECT
        id_destilaria,
        rua,
        COUNT(id_sensor) AS qtdSensor,
        MAX(temperatura) AS max_temp,
        MIN(temperatura) AS min_temp,
        MAX(umidade) AS max_umid,
        MIN(umidade) AS min_umid 
    FROM destilaria_registro_base 
    WHERE 
       TIMESTAMP(dt_coleta, hr_coleta) >= DATE_SUB(NOW(), INTERVAL ${horas}
     HOUR)
    GROUP BY id_destilaria, rua;
`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function maiorIntervalo(horas) {
  var instrucaoSql = `
        SELECT 
            e.rua,
            TIMESTAMPDIFF(HOUR, MAX(TIMESTAMP(r.dt_coleta, r.hr_coleta)), NOW()) as horas_consecutivas
        FROM registro r
        JOIN sensor s ON r.fk_sensor = s.id_sensor
        JOIN destilaria d ON s.fk_destilaria = d.id_destilaria
        JOIN endereco e ON d.fk_endereco = e.id_endereco
        WHERE 
            r.temperatura BETWEEN 18 AND 25
            AND 
            TIMESTAMP(r.dt_coleta, r.hr_coleta) >= DATE_SUB(NOW(), INTERVAL ${horas}
            HOUR)
        GROUP BY d.id_destilaria, e.rua
        ORDER BY horas_consecutivas DESC limit 1 ;

`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function eficiencia(horas) {
  var instrucaoSql = `
        SELECT 
      round(SUM(case when r.temperatura BETWEEN 18 AND 25 then 1 else 0 end) / count( r.temperatura) * 100 )as eficiencia
      FROM registro r
      JOIN sensor s ON r.fk_sensor = s.id_sensor
      LEFT JOIN localidade_sensor l ON s.fk_idLocalidadeSensor = l.id_localidadeSensor
      JOIN destilaria d ON s.fk_destilaria = d.id_destilaria
      WHERE 
     TIMESTAMP(r.dt_coleta, r.hr_coleta) >= DATE_SUB(NOW(), INTERVAL ${horas}
     HOUR);

`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


function buscarDestilaria(id) {
  var instrucaoSql = `SELECT * FROM destilaria where id_destilaria = '${id}';`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresaId, descricao) {
  var instrucaoSql = `INSERT INTO (descricao, fk_empresa) destilaria VALUES (${descricao}, ${empresaId})`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  listarDestilaria,
  buscarDestilaria,
  maiorIntervalo,
  eficiencia,
  cadastrar
}
