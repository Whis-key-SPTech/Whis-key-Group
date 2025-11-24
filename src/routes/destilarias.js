var express = require("express");
var router = express.Router();

var destilariaController = require("../controllers/destilariaController");

router.get("/:empresaId", function (req, res) {
  destilariaController.buscarDestilariasPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  destilariaController.cadastrar(req, res);
})

module.exports = router;