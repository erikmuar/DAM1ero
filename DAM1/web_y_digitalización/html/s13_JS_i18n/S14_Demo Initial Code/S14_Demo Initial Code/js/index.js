// Obtenir l'idioma de la URL si existeix i executar la funció "changeLanguage"
const querystring = window.location.search; // Si la url és: https://miweb.es?lang=es , retorna ?lang=es
const urlParams = new URLSearchParams(querystring);
if (urlParams.get('lang')){
  const lang = urlParams.get('lang');
  changeLanguage(lang);
}

async function changeLanguage(lang) {
  // Guardar l'idioma a la URL
  const newURL = window.location.protocol + '//' + window.location.host + window.location.pathname + '?lang=' + lang;
  window.history.replaceState({}, '', newURL);

  // Obtenir el fitxer json corresponent
  const response = await fetch(`./i18n/${lang}.json`);
  const data = await response.json();

  // Canviar els texts (Aquesta és la part que heu de modificar)

  console.log(data)

  document.getElementById('titulo').innerText = data.titulo 
  document.getElementById('first-name-label').innerText = data["first-name-label"] //Lo que hacemos con esto es cambiar el elemento ID "first-name-label" del html por lo que haya dentro del "first-name-label" del json de data, que se genera al poner en o es en la petición y cambia con el response y data. 
  document.getElementById('last-name-label').innerText = data["last-name-label"]
  document.getElementById('email').innerText = data["email"]
  document.getElementById('last-name-label').innerText = data["last-name-label"]

}