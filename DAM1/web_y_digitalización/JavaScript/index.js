let a = 20 ; // number
let b = "string" //string
let c = true // boolean
let d = undefined // undefined 
let e = null // null 


var alice;

;var bob = "Bob"

alice = "Alice";

alice = 'Alice'; 


const z = "60"; // es otra forma de declarar una variable pero no se puede cambiar su valor



function main(){





a = "Hola"
console.log(a) // Hola 


const titulo = document.getElementById("titulo")

titulo.innerHTML= "Hola mundo!!!!1111"  // cambia el h1 con id titulo y pones lo que quieras en el nuevo titulo 
titulo.style.backgroundColor = "blue"

titulo.classList.add("Menganito")



console.log("titulo: ", titulo)


}


setTimeout(main, 4000);



// se puede invocar una funcion asignandola a una variable 




const x = function(){
    return 300;
}


console.log(x());


// las dos formas son validas para hacer una función 

// function declaration 
function suma(a,b){
    return a+b;
    
    }
    
    // function expression 
    
    
    const resta = function(a,b){
    
        return a-b;
    }


    const resultado2 = resta(1,4)



    // arrow function 

    const multiplicacion = (a,b)=> {
        return a*b

    }
    
    const resultado3 = multiplicacion(2,3)
    
// en array puedes tener cualquier cosa metida, no hace falta que sean del mismo tipo


let arr1 = ["A", 10, b, true, ["otro","array"], {a:10, b:20}]

// Objetos


let obj = {

name:"Yuri",
age: 20,
hobbies: ["leer", "dormir", "comer"],
obj:{
    a:10,
    b:20
}

}
console.log(arr1[1] + arr1[2])

//Para acceder a las variables de un objeto


console.log(obj.name)
console.log(obj["name"])
console.log(obj.obj.a)



// Array de objetos 


const users= [
{
name: "Alice",
age: 20
},
{
name: "Bob",
age: 30
},
{
name: "Charlie",
age: 40
},

]

// ARRAYS 




// .push para meter un elemento al final del array


users.push({
    name:"David",
     age: 50
    });

    console.table(users)


    const usuarioprimero = users.shift();
    console.log(usuarioprimero);




users.push({
    name:"Carlos",
     age: 10
    });


    
users.push({
    name:"Alberto",
     age: 40
    });



    // .filter 


    
