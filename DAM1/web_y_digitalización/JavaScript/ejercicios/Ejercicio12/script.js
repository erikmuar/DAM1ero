document.getElementById('formulario').addEventListener('submit', function(e) {
    e.preventDefault();

    const texto = document.getElementById('texto').value.toLowerCase();
    const letras = {};
    const palabras = {};

    for (let letra of texto) {
        if (letra.match(/[a-záéíóúñ]/i)) {
            letras[letra] = (letras[letra] || 0) + 1;
        }
    }

    const listaPalabras = texto.split(/\s+/);
    for (let palabra of listaPalabras) {
        if (palabra.trim() !== '') {
            palabras[palabra] = (palabras[palabra] || 0) + 1;
        }
    }

    let resultadoLetras = '<h3>Letras:</h3><ul>';
    for (let letra in letras) {
        resultadoLetras += `<li>Letra: ${letra} → ${letras[letra]} ${letras[letra] === 1 ? 'vez' : 'veces'}</li>`;
    }
    resultadoLetras += '</ul>';
    document.getElementById('resultado-letras').innerHTML = resultadoLetras;

    let resultadoPalabras = '<h3>Palabras:</h3><ul>';
    for (let palabra in palabras) {
        resultadoPalabras += `<li>Palabra: ${palabra} → ${palabras[palabra]} ${palabras[palabra] === 1 ? 'vez' : 'veces'}</li>`;
    }
    resultadoPalabras += '</ul>';
    document.getElementById('resultado-palabras').innerHTML = resultadoPalabras;


});
