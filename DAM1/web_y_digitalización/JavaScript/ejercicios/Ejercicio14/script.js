document.getElementById('formulario').addEventListener('submit', function(e) {
    e.preventDefault();
  
    const nombrePais = document.getElementById('pais').value;
    const url = `https://restcountries.com/v3.1/name/${nombrePais}`;
  
    fetch(url)
      .then(res => res.json())
      .then(data => {
        const pais = data[0];
  
        const bandera = pais.flags.png;
        const poblacion = pais.population;
        const idioma = Object.values(pais.languages)[0];
        const moneda = Object.values(pais.currencies)[0].name;
  
        document.getElementById('resultado').innerHTML = `
          <p><img src="${bandera}" alt="Bandera" width="150"></p>
          <p>Población: ${poblacion}</p>
          <p>Idioma principal: ${idioma}</p>
          <p>Moneda: ${moneda}</p>
        `;
      });
  });
  