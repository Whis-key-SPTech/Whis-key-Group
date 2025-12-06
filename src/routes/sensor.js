var express = require("express");
var router = express.Router();

var sensoresController = require("../controllers/sensoresController");

router.get("/all/:idDestilaria", function (req, res) {
  sensoresController.listar(req, res);
});


router.get("/maiorIntervalo/:idDestilaria", function (req, res) {
  sensoresController.maiorIntervalo(req, res);
});
router.get("/eficiencia/:idDestilaria", function (req, res) {
  sensoresController.eficiencia(req, res);
});

router.get("/buscar/:id", function (req, res) {
  sensoresController.buscarPorId(req, res);
});

router.post("/cadastrar", function (req, res) {
  aquarioController.cadastrar(req, res);
})



module.exports = router;