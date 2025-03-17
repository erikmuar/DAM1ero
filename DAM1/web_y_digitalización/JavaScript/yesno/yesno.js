

const texto = document.getElementById("juanjo")



async function main(){

    const response = await fetch("https://yesno.wtf/api");

    if(!response.ok) return;

 
    const data = await response.json();

    
    const newDiv = document.createElement("div");

    texto.innerHTML = `<p>${data.answer}</p><img src="${data.image}" alt="${data.answer}">`;


    result.appendChild(newDiv);

}

main();