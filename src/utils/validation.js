const LIMITES_TEMPERATURA = {
    GRAVE_EXTREMO_SUPERIOR: 35,
    ATENCAO_SUPERIOR: 30,        
    ESTAVEL_SUPERIOR: 30,        
    ESTAVEL_INFERIOR: 20,        
    ATENCAO_INFERIOR: 15,       
    GRAVE_EXTREMO_INFERIOR: 15 
};
const LIMITES_UMIDADE = {
    GRAVE_EXTREMO_SUPERIOR: 95,
    ATENCAO_SUPERIOR: 85,        
    ESTAVEL_SUPERIOR: 85,        
    ESTAVEL_INFERIOR: 40,        
    ATENCAO_INFERIOR: 20,       
    GRAVE_EXTREMO_INFERIOR: 20 
};


function verificarStatusTemperatura(temperatura) {
    if (temperatura >= LIMITES_TEMPERATURA.GRAVE_EXTREMO_SUPERIOR || 
        temperatura <= LIMITES_TEMPERATURA.GRAVE_EXTREMO_INFERIOR) {
        return "GRAVE";
    } 
    
    else if (temperatura > LIMITES_TEMPERATURA.ATENCAO_SUPERIOR || 
               temperatura < LIMITES_TEMPERATURA.ESTAVEL_INFERIOR) {
        return "ATENCAO";
    }
    
    else { 
        return "ESTAVEL";
    }
}
function verificarStatusUmidade(umidade) {

    if (umidade >= LIMITES_UMIDADE.GRAVE_EXTREMO_SUPERIOR || 
        umidade <= LIMITES_UMIDADE.GRAVE_EXTREMO_INFERIOR) {
        return "GRAVE";
    } 
    
    else if (umidade > LIMITES_UMIDADE.ATENCAO_SUPERIOR || 
               umidade < LIMITES_UMIDADE.ESTAVEL_INFERIOR) {
        return "ATENCAO";
    }
    
    else { 
        return "ESTAVEL";
    }
}
module.exports = { verificarStatusTemperatura,verificarStatusUmidade, LIMITES_TEMPERATURA };