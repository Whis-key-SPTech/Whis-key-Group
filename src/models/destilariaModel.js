var database = require("../database/config");

function listarDestilaria() {
  var instrucaoSql = `
  SELECT count(sensor.id_sensor) as qtdSensor, endereco.rua as rua, MAX(registro.temperatura) as max_temp, MIN(registro.temperatura) as min_temp,  MAX(registro.umidade) as max_umid, MIN(registro.umidade) as min_umid FROM destilaria left join endereco on endereco.id_endereco = destilaria.fk_endereco join
 sensor on sensor.fk_destilaria = destilaria.id_destilaria join registro on registro.fk_sensor = sensor.id_sensor WHERE
    registro.dt_coleta >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)  group by endereco.rua;
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
  cadastrar
}
