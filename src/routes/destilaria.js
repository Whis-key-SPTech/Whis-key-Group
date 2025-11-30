var express = require("express");
var router = express.Router();

var destilariaController = require("../controllers/destilariaController");

router.get("/all", function (req, res) {
  destilariaController.listar(req, res);
});

router.get("/maiorIntervalo", function (req, res) {
  destilariaController.maiorIntervalo(req, res);
});
router.get("/eficiencia", function (req, res) {
  destilariaController.eficiencia(req, res);
});
router.get("/buscar/:id", function (req, res) {
  destilariaController.buscarPorId(req, res);
});

router.post("/cadastrar", function (req, res) {
  aquarioController.cadastrar(req, res);
})

module.exports = router;