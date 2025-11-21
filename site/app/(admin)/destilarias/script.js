
var filterButtons = document.querySelectorAll('.filter ul li');
var galleryItems = document.querySelectorAll('.cartao-destilaria');

for (var i = 0; i < filterButtons.length; i++) {
    
    filterButtons[i].addEventListener('click', function() {
        
        for (var j = 0; j < filterButtons.length; j++) {

            filterButtons[j].className = 'filter';
        }
        
        this.className = 'filter-active';
        
        var filterValue = this.dataset.filter;

        // Analisa cada item do cartao
        for (var k = 0; k < galleryItems.length; k++) {
            var item = galleryItems[k]; // Pega o cartão atual

            // Se o filtro for "todas" OU o cartão tiver a classe do filtro
            if (filterValue === 'todas' || item.classList.contains(filterValue)) {
                item.classList.remove('hide');
            } else {
                item.classList.add('hide');
            }
        }
    });
}