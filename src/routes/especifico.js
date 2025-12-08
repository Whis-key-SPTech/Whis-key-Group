var express = require("express");
var router = express.Router();

var especificoController = require("../controllers/especificoController");

// DashBoard Sensor
router.get("/tempAtual/:idSensor", function (req, res) {
  especificoController.tempAtual(req, res);
});

router.get("/umidAtual/:idSensor", function (req, res) {
  especificoController.umidAtual(req, res);
});

router.get("/contagemStatus/:idSensor", function (req, res) {
  especificoController.contagemStatus(req, res);
});

router.get("/tempHistorico/:idSensor", function (req, res) {
  especificoController.tempHistorico(req, res);
});

router.get("/umidHistorico/:idSensor", function (req, res) {
  especificoController.umidHistorico(req, res);
});





module.exports = router;