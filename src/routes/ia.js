var express = require("express");
var router = express.Router();

var iaController = require("../controllers/iaController");

// rota para perguntar à IA
router.post("/perguntar", iaController.perguntar);

module.exports = router;