
const result = document.getElementById("result");


// async espera hace que se espere la funcion hasta que se resuelva la promesa
// await espera a que se resuelva la promesa

async function main(){

    const response = await fetch("https://pokeapi.co/api/v2/pokemon");
    if(!response.ok) return; // si no devuelve nada no hace nada, es una forma de no usar else, a la que no va bien pones return y se cierra la funcion
    const data = await response.json();

    console.log(data.results); // se consolea el data.results porque el array esta dentro de results que esta dentro de data en la api de pokemon

        function printElement (element){


            const newDiv = document.createElement("div"); // esto es para crear un div que contenga lo que quiero crear en el html

            newDiv.innerHTML= "<a href='"+ element.url + "'>" + element.name + "</a>" // newDiv.innerHTML --> esto es para poner lo que quiero que ontenga el div 
            result.appendChild(newDiv); // esto es para añadir el div al html
            }
            
            
    printElement({
        name:"Paco",
        url: "https://google.com"
    });

    data.results.forEach(printElement); 




        }


    // data.results.forEach(element => { // metodo for each para recorrer el array de objetos
    //     const newDiv = document.createElement("div");
    //     newDiv.innerHTML = "**" + element.name + "**";
    //     result.appendChild(newDiv);
    // })



    
    // esto es para que recorra el array de objetos y ejecute la funcion printElement
main();