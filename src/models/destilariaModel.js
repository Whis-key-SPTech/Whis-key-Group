var database = require("../database/config");

function buscarDestilarias() {

  var instrucaoSql = `SELECT * FROM destilaria`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresa_id, descricao) {
  
  var instrucaoSql = `INSERT INTO (descricao, fk_empresa) destilaria VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarDestilarias,
  cadastrar
}
