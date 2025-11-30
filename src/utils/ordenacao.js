
function ordenar(listaOrdenada){
    for(var i = 0; i < listaOrdenada.length - 1; i++){
      for(var j = 0; j < listaOrdenada.length - 1 - i; j++){
          var atual = listaOrdenada[j]
          var proximo = listaOrdenada[j + 1]
        if(atual.peso < proximo.peso){
          listaOrdenada[j]  = proximo
          listaOrdenada[j + 1] = atual
        }
      }
    }
    return listaOrdenada
}

module.exports = { ordenar };