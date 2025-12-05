var express = require("express");
var router = express.Router();

var sensorController = require("../controllers/sensoresController");

router.get("/all/:idDestilaria", function (req, res) {
  sensorController.listar(req, res);
});


router.get("/maiorIntervalo/:idDestilaria", function (req, res) {
  sensorController.maiorIntervalo(req, res);
});
router.get("/eficiencia/:idDestilaria", function (req, res) {
  sensorController.eficiencia(req, res);
});

router.get("/buscar/:id", function (req, res) {
  sensorController.buscarPorId(req, res);
});

router.post("/cadastrar", function (req, res) {
  aquarioController.cadastrar(req, res);
})



// DashBoard Sensor Específico 
router.get("/tempAtual/:idSensor", function (req, res) {
  sensorController.tempAtual(req, res);
});

router.get("/umidAtual/:idSensor", function (req, res) {
  sensorController.umidAtual(req, res);
});

router.get("/contagemStatus/:idSensor", function (req, res) {
  sensorController.contagemStatus(req, res);
});



module.exports = router;