document.getElementById('calculadora').addEventListener('submit', function(e) 
{
    e.preventDefault();

    const operacion = document.getElementById('operacion').value;
    const num1 = parseFloat(document.getElementById('numero1').value);
    const num2 = parseFloat(document.getElementById('numero2').value);
    let resultado;

    if (operacion === 'division' && num2 === 0) {
        document.getElementById('resultado').textContent = 'Error: no se puede dividir por 0.';
        return;
    }

    if (operacion === 'suma') {
        resultado = num1 + num2;
    } else if (operacion === 'resta') {
        resultado = num1 - num2;
    } else if (operacion === 'multiplicacion') {
        resultado = num1 * num2;
    } else if (operacion === 'division') {
        resultado = num1 / num2;
    }

    document.getElementById('resultado').textContent = 'Resultado: ' + resultado;
});









