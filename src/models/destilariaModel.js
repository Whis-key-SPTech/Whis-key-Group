var database = require("../database/config");

function listarDestilaria() {
  var instrucaoSql = `SELECT * FROM destilaria;`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarDestilaria(id) {
  var instrucaoSql = `SELECT * FROM destilaria where id_destilaria = '${id}';`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

<<<<<<< HEAD
function cadastrar(empresaId, descricao) {
=======
function cadastrar(empresa_id, descricao) {
  
>>>>>>> 6a7aa97abd3dec4ddc2ebf0db0039f9a0c85ec87
  var instrucaoSql = `INSERT INTO (descricao, fk_empresa) destilaria VALUES (${descricao}, ${empresaId})`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  listarDestilaria,
  buscarDestilaria,
  cadastrar
}
