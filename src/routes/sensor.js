var express = require("express");
var router = express.Router();

var sensorController = require("../controllers/sensorController");

router.get("/all", function (req, res) {
  sensorController.listar(req, res);
});

router.get("/buscar/:id", function (req, res) {
  sensorController.buscarPorId(req, res);
});

router.post("/cadastrar", function (req, res) {
  aquarioController.cadastrar(req, res);
})

module.exports = router;