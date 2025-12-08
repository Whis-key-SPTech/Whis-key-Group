var especificoModel = require("../models/especificoModel");
// var validationsStatus = require("../utils/validation");

function tempAtual(req, res) {
  var idSensor = req.params.idSensor;
  especificoModel.tempAtual(idSensor)
        .then(
            function (resultado) {
                if (resultado.length > 0) {
                    res.json(resultado[0]);
                } else {
                    res.status(204).send("Nenhum resultado encontrado!");
                }
            })
        .catch(
            function (erro) {
                console.log(
                    "Houve um erro ao buscar temperatura atual do sensor: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function umidAtual(req, res) {
  var idSensor = req.params.idSensor;
  especificoModel.umidAtual(idSensor)
        .then(
            function (resultado) {
                if (resultado.length > 0) {
                    res.json(resultado[0]);
                } else {
                    res.status(204).send("Nenhum resultado encontrado!");
                }
            })
        .catch(
            function (erro) {
                console.log(
                    "Houve um erro ao buscar umidade atual do sensor: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function contagemStatus(req, res) {
  var idSensor = req.params.idSensor;

  especificoModel.contagemStatus(idSensor)
      .then(resultado => {
          if (resultado.length > 0) {
              res.status(200).json(resultado[0]);
          } else {
              res.status(200).json({
                  grave: 0,
                  atencao: 0,
                  estavel: 0
              });
          }
      })
      .catch(erro => {
          console.log("Erro ao buscar contagem:", erro.sqlMessage);
          res.status(500).json(erro.sqlMessage);
      });
}


function tempHistorico(req, res) {
    var idSensor = req.params.idSensor;

    especificoModel.tempHistorico(idSensor)
        .then(resultado => {
            if (resultado.length > 0) {
                res.json(resultado);
            } else {
                res.status(204).send([]);
            }
        })
        .catch(erro => {
            console.log("Erro:", erro);
            res.status(500).json(erro);
        });
}

function umidHistorico(req, res) {
    var idSensor = req.params.idSensor;

    especificoModel.umidHistorico(idSensor)
        .then(resultado => {
            if (resultado.length > 0) {
                res.json(resultado);
            } else {
                res.status(204).send([]);
            }
        })
        .catch(erro => {
            console.log("Erro:", erro);
            res.status(500).json(erro);
        });
}





module.exports = {
  tempAtual,
  umidAtual,
  contagemStatus,
  tempHistorico,
  umidHistorico
}