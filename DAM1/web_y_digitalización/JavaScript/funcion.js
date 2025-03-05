async function main(){

    const response = await fetch("https://pokeapi.co/api/v2/pokemon");
    if(!response.ok)return;
    const data = await response.json();

    console.log(data);

    data.results.forEach(element => {
        const newDiv = document.createElement("div");
        newDiv.innerHTML = "**" + element.name + "**";
        result.appendChild(newDiv);
    
    )
);

}