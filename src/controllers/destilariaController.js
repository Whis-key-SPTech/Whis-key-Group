var destilariaModel = require("../models/destilariaModel");
var validationsStatus = require("../utils/validation");
function listar(req, res) {
  var statusFiltro = req.query.situacao || 'ALL';
  statusFiltro = statusFiltro.toLowerCase();
  var listaOrdenada = []

  destilariaModel.listarDestilaria().then((resultado) => {
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
    res.status(200).json(listaOrdenada);
  });
}
function buscarPorId(req, res) {
  var id = req.params.id;
  destilariaModel.buscarDestilaria(id).then((resultado) => {
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


    destilariaModel.cadastrar(descricao, idUsuario)
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