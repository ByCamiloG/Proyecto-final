<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="includes/header.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <title>Contacto - Gildardo Gutiérrez</title>
  <link rel="stylesheet" href="css/styles.css">

  <style>
    .contact-page {
      background-image: url("imagenes/contacto.jpg");
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .contact-overlay {
      background-color: rgba(0, 0, 0, 0.6);
      padding: 60px 20px;
      border-radius: 10px;
      width: 100%;
      max-width: 700px;
      text-align: center;
    }

    .contact-content h1 {
      font-size: 32px;
      margin-bottom: 20px;
      color: white;
    }

    .contact-content p {
      margin: 5px 0;
      font-size: 18px;
      color: white;
    }

    .contact-form {
      margin-top: 30px;
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 15px;
    }

    .contact-form textarea,
    .contact-form input {
      width: 100%;
      max-width: 400px;
      padding: 12px;
      font-size: 16px;
      border-radius: 8px;
      border: 1px solid #ccc;
      resize: vertical;
      background-color: rgba(255, 255, 255, 0.95);
      color: #333;
    }

    .contact-form button {
      padding: 12px 24px;
      font-size: 16px;
      border: none;
      border-radius: 8px;
      background-color: #fff;
      color: #000;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .contact-form button:hover {
      background-color: #ddd;
    }

    .contact-map {
      margin-top: 40px;
    }

    iframe {
      border-radius: 8px;
    }
  </style>
</head>
<body>

<main class="contact-page">
  <div class="contact-overlay">
    <div class="contact-content">
      <h1>¿NECESITAS AYUDA?<br>CONTÁCTANOS</h1>

      <p>📞 312 581 0054</p>
      <p>📧 gildarogutierrez29@gmail.com</p>
      <p>📱 Gildardo Gutierrez Peluqueria</p>

      <form class="contact-form" onsubmit="enviarMensaje(); return false;">
        <textarea id="mensaje" placeholder="Escribe tu mensaje aquí..." required></textarea>
        <input type="text" id="nombre" placeholder="Tu nombre" required>
        <button type="submit">Enviar mensaje</button>
      </form>

      <div class="contact-map">
        <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d248.58719662521509!2d-74.12197454882259!3d4.5226201541127615!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1ses!2sco!4v1752713881924!5m2!1ses!2sco"
                width="100%" 
                height="300" 
                style="border:0;" 
                allowfullscreen="" 
                loading="lazy" 
                referrerpolicy="no-referrer-when-downgrade"></iframe>
      </div>
    </div>
  </div>
</main>

<%@ include file="includes/footer.jsp" %>

<!-- Firebase SDKs -->
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-database-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-auth-compat.js"></script>

<script>
  const firebaseConfig = {
    apiKey: "AIzaSyCDZvWq953WtoXTR-BvNDT-qiaocjrmeyM",
    authDomain: "peluqueriagildardo.firebaseapp.com",
    projectId: "peluqueriagildardo",
    storageBucket: "peluqueriagildardo.appspot.com",
    messagingSenderId: "585702751886",
    appId: "1:585702751886:web:41553292b19d9aa5cc13df",
    measurementId: "G-3RV5FX2GPN",
    databaseURL: "https://peluqueriagildardo-default-rtdb.firebaseio.com"
  };

  if (!firebase.apps.length) {
    firebase.initializeApp(firebaseConfig);
  }

  const db = firebase.database();

  function enviarMensaje() {
    const nombre = document.getElementById("nombre").value;
    const mensaje = document.getElementById("mensaje").value;

    if (nombre && mensaje) {
      const nuevaEntrada = db.ref("mensajes").push();
      nuevaEntrada.set({
        nombre: nombre,
        mensaje: mensaje,
        fecha: new Date().toISOString()
      });

      alert("Gracias por tu mensaje, " + nombre + "!");
      document.getElementById("nombre").value = "";
      document.getElementById("mensaje").value = "";
    } else {
      alert("Por favor completa ambos campos.");
    }
  }
    firebase.auth().onAuthStateChanged(function(user) {
    cargarProductos();
  });

  function cerrarSesion() {
    firebase.auth().signOut().then(() => {
      alert("Sesión cerrada");
      location.reload();
    });
  }

  HTMLFormElement.prototype.reset = function() {
    Array.from(this.elements).forEach(el => {
      if (el.type !== "button" && el.type !== "submit") el.value = "";
    });
  };
</script>

</body>
</html>
