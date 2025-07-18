<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="includes/header.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <title>Agendar Cita - Gildardo Gutiérrez</title>
  <link rel="stylesheet" href="styles.css">
  <style>
    body, html {
      margin: 0;
      padding: 0;
      height: 100%;
      font-family: 'Poppins', sans-serif;
    }

    .agendar-page {
      background-image: url("imagenes/salon-belleza.jpg"); /* misma imagen de index */
      background-size: cover;
      background-position: center;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
    }

    .agendar-overlay {
      background-color: rgba(0, 0, 0, 0.6);
      padding: 40px;
      border-radius: 16px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
      color: #fff;
      width: 90%;
      max-width: 500px;
    }

    .agendar-content h1 {
      text-align: center;
      margin-bottom: 30px;
      font-size: 32px;
      color: #fff;
    }

    form {
      display: flex;
      flex-direction: column;
    }

    form input,
    form select {
      padding: 12px;
      margin-bottom: 15px;
      border: none;
      border-radius: 8px;
      font-size: 16px;
    }

    .agenda-button {
      padding: 12px;
      background-color: #f4c10f;
      border: none;
      border-radius: 8px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .agenda-button:hover {
      background-color: #e0af0b;
    }

    #mensaje-cita {
      margin-top: 12px;
      font-weight: 500;
      text-align: center;
    }
  </style>
</head>
<body>

<main class="agendar-page">
  <div class="agendar-overlay">
    <div class="agendar-content">
      <h1>AGENDA TU CITA</h1>

      <form onsubmit="guardarCita(event)">
        <input type="text" id="nombre" placeholder="Nombre completo" required>
        <select id="servicio" required>
          <option value="">Seleccione un servicio</option>
          <option value="Corte de cabello">Corte de cabello</option>
          <option value="Coloración">Coloración</option>
          <option value="Peinado">Peinado</option>
          <option value="Afeitado">Afeitado</option>
        </select>
        <input type="date" id="fecha" required>
        <input type="time" id="hora" required>
        <button type="submit" class="agenda-button">Agendar</button>
        <p id="mensaje-cita"></p>
      </form>
    </div>
  </div>
</main>

<%@ include file="includes/footer.jsp" %>

<!-- Firebase SDK -->
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-database-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-auth-compat.js"></script>

<script>
  const firebaseConfig = {
    apiKey: "AIzaSyCDZvWq953WtoXTR-BvNDT-qiaocjrmeyM",
    authDomain: "peluqueriagildardo.firebaseapp.com",
    databaseURL: "https://peluqueriagildardo-default-rtdb.firebaseio.com/",
    projectId: "peluqueriagildardo",
    storageBucket: "peluqueriagildardo.firebasestorage.app",
    messagingSenderId: "585702751886",
    appId: "1:585702751886:web:41553292b19d9aa5cc13df"
  };

  firebase.initializeApp(firebaseConfig);

  function guardarCita(e) {
    e.preventDefault();

    const nombre = document.getElementById('nombre').value.trim();
    const servicio = document.getElementById('servicio').value;
    const fecha = document.getElementById('fecha').value;
    const hora = document.getElementById('hora').value;

    if (!nombre || !servicio || !fecha || !hora) {
      mostrarMensaje("Por favor complete todos los campos.", "#f44336");
      return;
    }

    const nuevaCita = {
      nombre,
      servicio,
      fecha,
      hora,
      timestamp: new Date().toISOString()
    };

    firebase.database().ref('citas').push(nuevaCita)
      .then(() => {
        mostrarMensaje("✅ Cita agendada exitosamente.", "#4CAF50");
        document.querySelector('form').reset();
      })
      .catch(error => {
        console.error("Error al guardar cita:", error);
        mostrarMensaje("❌ Error al guardar la cita.", "#f44336");
      });
  }

  function mostrarMensaje(texto, color) {
    const mensaje = document.getElementById('mensaje-cita');
    mensaje.innerText = texto;
    mensaje.style.color = color;
  }

  // Función cerrar sesión para botón en el header (id="btnLogout")
  const logoutBtn = document.getElementById("btnLogout");
  if (logoutBtn) {
    logoutBtn.addEventListener("click", () => {
      firebase.auth().signOut()
        .then(() => {
          alert("Has cerrado sesión.");
          window.location.href = "index.jsp";
        })
        .catch((error) => {
          alert("Error al cerrar sesión: " + error.message);
        });
    });
  }
</script>

</body>
</html>
