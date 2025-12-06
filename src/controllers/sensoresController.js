var sensoresModel = require("../models/sensoresModel");
var validationsStatus = require("../utils/validation");


function listar(req, res) {
  var statusFiltro = req.query.situacao || 'ALL';
  var statusData = req.query.horas || 12;
  var destilariaId = req.params.idDestilaria;
  statusFiltro = statusFiltro.toLowerCase();
  var listaOrdenada = []
  
  sensoresModel.listarSensores(destilariaId, statusData).then((resultado) => {
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
  sensoresModel.maiorIntervalo(destilariaId, statusData).then((resultado) => {
    res.status(200).json(resultado);
  });
}


function eficiencia(req, res) {
  var statusFiltro = req.query.situacao || 'ALL';
  var statusData = req.query.horas || 12;
  var destilariaId = req.params.idDestilaria;
  statusFiltro = statusFiltro.toLowerCase();
  sensoresModel.eficiencia(destilariaId, statusData).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function buscarPorId(req, res) {
  var id = req.params.id;
  sensoresModel.buscarSensor(id).then((resultado) => {
    res.status(200).json(resultado);
  });
}



// DashBoard Sensor Específico 



module.exports = {
  listar,
  maiorIntervalo,
  eficiencia,
  buscarPorId
}