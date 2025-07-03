<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="includes/header.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <title>Agendar Cita - Gildardo Gutiérrez</title>
  <link rel="stylesheet" href="styles.css">
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
        <p id="mensaje-cita" style="margin-top: 10px;"></p>
      </form>
    </div>
  </div>
</main>

<%@ include file="includes/footer.jsp" %>

<!-- Firebase SDK -->
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-database-compat.js"></script>

<script>
  // Configuración Firebase
  const firebaseConfig = {
    apiKey: "AIzaSyCDZvWq953WtoXTR-BvNDT-qiaocjrmeyM",
    authDomain: "peluqueriagildardo.firebaseapp.com",
    databaseURL: "https://peluqueriagildardo-default-rtdb.firebaseio.com/",
    projectId: "peluqueriagildardo",
    storageBucket: "peluqueriagildardo.firebasestorage.app",
    messagingSenderId: "585702751886",
    appId: "1:585702751886:web:41553292b19d9aa5cc13df"
  };

  // Inicializar Firebase
  firebase.initializeApp(firebaseConfig);
  const database = firebase.database();

  // Guardar cita
  function guardarCita(e) {
    e.preventDefault();

    const nombre = document.getElementById('nombre').value;
    const servicio = document.getElementById('servicio').value;
    const fecha = document.getElementById('fecha').value;
    const hora = document.getElementById('hora').value;

    const nuevaCita = {
      nombre,
      servicio,
      fecha,
      hora,
      timestamp: new Date().toISOString()
    };

    database.ref('citas').push(nuevaCita)
      .then(() => {
        document.getElementById('mensaje-cita').innerText = "✅ Cita agendada exitosamente";
        document.getElementById('mensaje-cita').style.color = "#4CAF50";
        document.querySelector('form').reset();
      })
      .catch(error => {
        document.getElementById('mensaje-cita').innerText = "❌ Error al guardar la cita";
        console.error(error);
      });
  }
</script>

</body>
</html>
