var express = require("express");
var router = express.Router();

var destilariaontroller = require("../controllers/destilariaController");

router.get("/destilatia", function (req, res) {
  destilariaontroller.buscarDestilaria(req, res);
});

router.post("/cadastrar", function (req, res) {
  aquarioController.cadastrar(req, res);
})

module.exports = router;