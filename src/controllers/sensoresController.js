var sensorModel = require("../models/sensoresModel");
var validationsStatus = require("../utils/validation");


function listar(req, res) {
  var statusFiltro = req.query.situacao || 'ALL';
  var statusData = req.query.horas || 12;
  var destilariaId = req.params.idDestilaria;
  statusFiltro = statusFiltro.toLowerCase();
  var listaOrdenada = []
  
  sensorModel.listarSensores(destilariaId, statusData).then((resultado) => {
    for (var i = 0; i < resultado.length; i++) {
      var maxTempStatus = validationsStatus.verificarStatusTemperatura(resultado[i].max_temp)
      var minTempStatus = validationsStatus.verificarStatusTemperatura(resultado[i].min_temp)
      var maxUmidStatus = validationsStatus.verificarStatusUmidade(resultado[i].max_umid)
      var minUmidStatus = validationsStatus.verificarStatusUmidade(resultado[i].min_umid)
      if (maxTempStatus == 'GRAVE' || minTempStatus == 'GRAVE' || maxUmidStatus == 'GRAVE' || minUmidStatus == 'GRAVE') {
        resultado[i].situacao = 'GRAVE'
        resultado[i].peso = 3
        if (statusFiltro == 'grave' || statusFiltro == 'all') {
          listaOrdenada.push(resultado[i])
        }
      } else if (maxTempStatus == 'ATENCAO' || minTempStatus == 'ATENCAO' || maxUmidStatus == 'ATENCAO' || minUmidStatus == 'ATENCAO') {
        resultado[i].situacao = 'ATENCAO'
          resultado[i].peso = 2
        if (statusFiltro == 'atencao' || statusFiltro == 'all') {
          listaOrdenada.push(resultado[i])
        }
      } else {
        resultado[i].situacao = 'ESTAVEL'
        resultado[i].peso = 1
        if (statusFiltro == 'estavel' || statusFiltro == 'all') {
          listaOrdenada.push(resultado[i])
        }
      }
    }
    for(var i = 0; i < listaOrdenada.length - 1; i++){
      for(var j = 0; j < listaOrdenada.length - 1 - i; j++){
          var atual = listaOrdenada[j]
          var proximo = listaOrdenada[j + 1]
        if(atual.peso < proximo.peso){
          listaOrdenada[j]  = proximo
          listaOrdenada[j + 1] = atual
        }
      }
    }
    res.status(200).json(listaOrdenada);
  });
}


function maiorIntervalo(req, res) {
  var statusFiltro = req.query.situacao || 'ALL';
  var statusData = req.query.horas || 12;
  var destilariaId = req.params.idDestilaria;
  statusFiltro = statusFiltro.toLowerCase();
  sensorModel.maiorIntervalo(destilariaId, statusData).then((resultado) => {
    res.status(200).json(resultado);
  });
}


function eficiencia(req, res) {
  var statusFiltro = req.query.situacao || 'ALL';
  var statusData = req.query.horas || 12;
  var destilariaId = req.params.idDestilaria;
  statusFiltro = statusFiltro.toLowerCase();
  sensorModel.eficiencia(destilariaId, statusData).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function buscarPorId(req, res) {
  var id = req.params.id;
  sensorModel.buscarSensor(id).then((resultado) => {
    res.status(200).json(resultado);
  });
}



// DashBoard Sensor Específico 

function tempAtual(req, res) {
  var idSensor = req.params.idSensor;
  sensorModel.tempAtual(idSensor)
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
  sensorModel.umidAtual(idSensor)
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

  sensorModel.contagemStatus(idSensor)
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

module.exports = {
  listar,
  maiorIntervalo,
  eficiencia,
  buscarPorId,
  tempAtual,
  umidAtual,
  contagemStatus
}