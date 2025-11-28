const iaModel = require("../models/iaModel");

async function perguntar(req, res) {
    const pergunta = req.body.pergunta;

    try {
        const resposta = await iaModel.gerarResposta(pergunta);
        res.json({ resultado: resposta });
    } catch (error) {
        res.status(500).json({ error: "Erro interno da IA" });
    }
}

module.exports = {
    perguntar
};