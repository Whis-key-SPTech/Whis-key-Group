var sensorModel = require("../models/sensorModel");

function listar(req, res) {
  sensorModel.listarSensor().then((resultado) => {
    res.status(200).json(resultado);
  });
}
function buscarPorId(req, res) {
  var id = req.params.id;
  sensorModel.buscarSensor(id).then((resultado) => {
    res.status(200).json(resultado);
  });
}


function cadastrar(req, res) {
  var descricao = req.body.descricao;
  var idUsuario = req.body.idUsuario;

  if (descricao == undefined) {
    res.status(400).send("descricao está undefined!");
  } else if (idUsuario == undefined) {
    res.status(400).send("idUsuario está undefined!");
  } else {


    sensorModel.cadastrar(descricao, idUsuario)
      .then((resultado) => {
        res.status(201).json(resultado);
      }
      ).catch((erro) => {
        console.log(erro);
        console.log(
          "\nHouve um erro ao realizar o cadastro! Erro: ",
          erro.sqlMessage
        );
        res.status(500).json(erro.sqlMessage);
      });
  }
}

module.exports = {
  listar,
  buscarPorId,
  cadastrar
}