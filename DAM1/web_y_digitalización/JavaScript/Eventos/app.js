
const buttonA = document.getElementById("btn");

buttonA.addEventListener("click", handleClick);
buttonA.addEventListener("click", handleHover);



window.addEventListener("resize", function( )){

    console.log("Has cambiado el tamaño de la ventana");
}

function handleClick(event) {
  console.log("Has hecho click", event);
}




function handleHover(event) {
    console.log("Has pasado por encima", event);
  }