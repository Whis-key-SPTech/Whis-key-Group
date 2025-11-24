var database = require("../database/config");

function listarDestilaria() {
  var instrucaoSql = `SELECT count(sensor.id_sensor) as qtdSensor, endereco.nome_localidade FROM destilaria join endereco on endereco.id_endereco = destilaria.fk_endereco join sensor on sensor.fk_destilaria = destilaria.id_destilaria;
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
