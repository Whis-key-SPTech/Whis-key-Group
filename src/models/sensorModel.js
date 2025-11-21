var database = require("../database/config");

function listarSensor() {
  var instrucaoSql = `SELECT * FROM sensor;`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarSensor(id) {
  var instrucaoSql = `SELECT * FROM sensor where id_sensor = '${id}';`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresaId, descricao) {
  
  var instrucaoSql = `INSERT INTO (descricao, fk_empresa) sensor VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  listarSensor,
  buscarSensor,
  cadastrar
}
