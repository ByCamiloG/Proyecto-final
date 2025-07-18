<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="includes/header.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Servicios - Gildardo Gutiérrez</title>
  <link rel="stylesheet" href="css/styles.css">

  <style>
    body, html {
      margin: 0;
      padding: 0;
      height: 100%;
      font-family: 'Segoe UI', sans-serif;
      background-image: url("imagenes/salon-belleza.jpg");
      background-size: cover;
    }

    .contenedor-servicios {
      padding: 40px 20px;
      margin-top: 120px;
      text-align: center;
      color: #fff;
      background-color: rgba(0, 0, 0, 0.6);
      max-width: 750px;
      margin-left: auto;
      margin-right: auto;
      border-radius: 20px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
    }

    .formulario-corte {
      margin-top: 30px;
      background: rgba(255, 255, 255, 0.97);
      padding: 20px;
      border-radius: 15px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .formulario-corte input,
    .formulario-corte select,
    .formulario-corte button {
      display: block;
      width: 100%;
      margin: 15px 0;
      padding: 10px;
      border-radius: 10px;
      border: 1px solid #ccc;
      font-size: 16px;
    }

    .formulario-corte button {
      background-color: #111;
      color: #fff;
      cursor: pointer;
      transition: background 0.3s ease;
    }

    .formulario-corte button:hover {
      background-color: #333;
    }

    #imagen-generada {
      margin-top: 30px;
      max-width: 100%;
      border-radius: 15px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.4);
    }

    .loader {
      display: none;
      margin: 20px auto;
      border: 6px solid #f3f3f3;
      border-top: 6px solid #333;
      border-radius: 50%;
      width: 40px;
      height: 40px;
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    #boton-volver {
      display: none;
      margin-top: 20px;
      background-color: #fff;
      color: #111;
      border: none;
      padding: 10px 20px;
      border-radius: 10px;
      font-weight: bold;
      cursor: pointer;
    }

    #boton-volver:hover {
      background-color: #eee;
    }

    .aviso-subida {
      background-color: rgba(255, 255, 255, 0.9);
      color: #111;
      padding: 15px 20px;
      border-radius: 10px;
      font-size: 16px;
      text-align: left;
      margin-top: 25px;
      box-shadow: 0 3px 6px rgba(0,0,0,0.2);
    }

    .aviso-subida strong {
      color: #000;
    }

    .aviso-subida a {
      color: #007BFF;
      text-decoration: underline;
    }

  </style>
</head>

<body>

<div class="contenedor-servicios">
  <h1>Simula tu corte de cabello con IA</h1>
  <p>Pega la URL de una foto de tu rostro y elige un estilo. Verás una simulación generada con inteligencia artificial.</p>

  <!-- Aviso de ayuda -->
  <div class="aviso-subida">
    <strong>¿No sabes cómo obtener una URL de imagen?</strong><br>
    1. Sube tu foto a un servicio como <a href="https://postimages.org" target="_blank">PostImages</a>.<br>
    2. Una vez subida, Copia el enlace directo de la imagen.<br>
    3. Pega esa URL en el campo del formulario.<br>
    <em>Ejemplo válido:</em> <code>https://i.postimg.cc/501ZCvGK/MAT0836.jpg</code>
  </div>

  <!-- Formulario con URL -->
  <form class="formulario-corte" id="form-corte">
    <label for="imagenUrl">URL de tu foto:</label>
    <input type="text" name="imagenUrl" id="imagenUrl" placeholder="https://..." required>

    <label for="corte">Estilo de corte:</label>
    <select name="corte" id="corte" required>
      <option value="">Selecciona un estilo</option>
      <option value="fade moderno">Fade moderno</option>
      <option value="undercut clásico">Undercut clásico</option>
      <option value="corte con flequillo">Con flequillo</option>
      <option value="estilo pompadour">Pompadour</option>
      <option value="corte buzz">Buzz</option>
    </select>

    <button type="submit">Generar corte simulado</button>
  </form>

  <!-- Loader -->
  <div class="loader" id="loader"></div>

  <!-- Resultado -->
  <div id="resultado">
    <img id="imagen-generada" src="" alt="Resultado IA" style="display: none;">
    <button id="boton-volver">Probar otra imagen</button>
  </div>
</div>

<script>
  const form = document.getElementById('form-corte');
  const loader = document.getElementById('loader');
  const imagenGenerada = document.getElementById('imagen-generada');
  const botonVolver = document.getElementById('boton-volver');

  form.addEventListener('submit', function (e) {
    e.preventDefault();

    const imagenUrl = document.getElementById('imagenUrl').value;
    const corte = document.getElementById('corte').value;

    loader.style.display = 'block';
    imagenGenerada.style.display = 'none';
    botonVolver.style.display = 'none';

    fetch('<%=request.getContextPath()%>/generar-corte', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ imagenUrl, corte })
    })
    .then(async res => {
      if (!res.ok) {
        const text = await res.text();
        console.error("Respuesta no válida:", text);
        throw new Error("Respuesta del servidor no válida");
      }
      return res.json();
    })
    .then(data => {
      loader.style.display = 'none';
      if (data.imagenUrl) {
        document.querySelector('.formulario-corte').style.display = 'none';
        imagenGenerada.src = data.imagenUrl;
        imagenGenerada.style.display = 'block';
        botonVolver.style.display = 'inline-block';
      } else {
        alert("No se pudo generar la imagen. Intenta nuevamente.");
      }
    })
    .catch(err => {
      loader.style.display = 'none';
      console.error("Error en fetch:", err);
      alert("Ocurrió un error al generar la imagen.");
    });
  });

  botonVolver.addEventListener('click', function () {
    document.querySelector('.formulario-corte').reset();
    document.querySelector('.formulario-corte').style.display = 'block';
    imagenGenerada.style.display = 'none';
    botonVolver.style.display = 'none';
  });
</script>

</body>
</html>
