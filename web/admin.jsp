<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="includes/header.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <title>Administrador - Citas Agendadas</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>

<main class="admin-page">
  <div class="admin-content">
    <h1>CITAS AGENDADAS</h1>
    <p id="admin-email"></p>
    <table>
      <thead>
        <tr>
          <th>Nombre</th>
          <th>Servicio</th>
          <th>Fecha</th>
          <th>Hora</th>
        </tr>
      </thead>
      <tbody id="citas-body">
        <!-- Las citas se insertan aquí -->
      </tbody>
    </table>
    <p id="estado-admin" style="margin-top: 20px; color: #f66;"></p>
  </div>
</main>

<%@ include file="includes/footer.jsp" %>

<!-- Firebase SDKs -->
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-auth-compat.js"></script>
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
  firebase.initializeApp(firebaseConfig);

  // Función para cerrar sesión (por si se llama desde menú)
  function cerrarSesion() {
    firebase.auth().signOut()
      .then(() => window.location.href = "login.jsp")
      .catch(err => console.error("Error al cerrar sesión", err));
  }

  // Función segura para mostrar valores aunque estén mal formateados
  function obtenerValor(campo) {
    if (typeof campo === "string") return campo;
    if (typeof campo === "object" && campo !== null) {
      const primeraClave = Object.keys(campo)[0];
      return campo[primeraClave] || "-";
    }
    return "-";
  }

  // Cargar citas desde Firebase
  function cargarCitas() {
    const citasRef = firebase.database().ref("citas");

    citasRef.on("value", snapshot => {
      const citas = snapshot.val();
      const tbody = document.getElementById("citas-body");
      tbody.innerHTML = "";

      if (!citas) {
        tbody.innerHTML = "<tr><td colspan='4'>No hay citas registradas.</td></tr>";
        return;
      }

      Object.entries(citas).forEach(([id, cita]) => {
        if (!cita || typeof cita !== "object") return;

        const nombre = obtenerValor(cita.nombre);
        const servicio = obtenerValor(cita.servicio);
        const fecha = obtenerValor(cita.fecha);
        const hora = obtenerValor(cita.hora);

        const fila = document.createElement("tr");
        fila.innerHTML = `
          <td>${nombre}</td>
          <td>${servicio}</td>
          <td>${fecha}</td>
          <td>${hora}</td>
        `;
        tbody.appendChild(fila);
      });
    }, error => {
      console.error("Error al leer citas:", error);
      document.getElementById("estado-admin").innerText = "Error al cargar citas.";
    });
  }

  // Solo permite acceso si el usuario es administrador
  firebase.auth().onAuthStateChanged(user => {
    if (!user) {
      window.location.href = "login.jsp";
    } else {
      const adminEmail = "juanca.9738@gmail.com";
      if (user.email === adminEmail) {
        document.getElementById("admin-email").innerText = "Administrador: " + user.email;
        cargarCitas();
      } else {
        document.getElementById("estado-admin").innerText = "Acceso denegado: no eres administrador.";
      }
    }
  });
</script>

</body>
</html>
