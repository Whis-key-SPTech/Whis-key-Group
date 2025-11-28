const { GoogleGenAI } = require("@google/genai");

// configurando o gemini (IA)
const chatIA = new GoogleGenAI({
    apiKey: process.env.MINHA_CHAVE
});

async function gerarResposta(pergunta) {
    try {
        const modeloIA = chatIA.models.generateContent({
            model: "gemini-2.0-flash",
            contents: `Em um parágrafo responda: ${pergunta}`
        });

        const resposta = (await modeloIA).text;
        const tokens = (await modeloIA).usageMetadata;

        console.log("Tokens usados:", tokens);
        return resposta;

    } catch (error) {
        console.error("Erro IA:", error);
        throw error;
    }
}

module.exports = {
    gerarResposta
};