<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="includes/header.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <title>Mis Citas - Gildardo Gutiérrez</title>
  <link rel="stylesheet" href="styles.css">

  <style>
    .admin-page {
      background-image: url('imagenes/salon-belleza.jpg');
      background-size: cover;
      background-position: center;
      min-height: 100vh;
      padding: 50px 20px;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .tabla-citas {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 16px;
      padding: 20px;
      max-width: 1000px;
      width: 100%;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    }

    .tabla-citas h2 {
      text-align: center;
      margin-bottom: 20px;
      color: #333;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      color: #000;
    }

    th, td {
      padding: 12px 15px;
      border: 1px solid #ccc;
      text-align: center;
    }

    th {
      background-color: #000;
      color: white;
    }

    td {
      background-color: white;
    }

    .btn-eliminar {
      background-color: #f44336;
      color: white;
      border: none;
      padding: 6px 12px;
      cursor: pointer;
      border-radius: 8px;
    }

    @media screen and (max-width: 768px) {
      .tabla-citas {
        padding: 10px;
      }

      table, th, td {
        font-size: 14px;
      }
    }
  </style>
</head>
<body>

<main class="admin-page">
  <div class="tabla-citas">
    <h2>Citas Agendadas</h2>
    <table id="tabla-citas">
      <thead>
        <tr>
          <th>Nombre</th>
          <th>Servicio</th>
          <th>Fecha</th>
          <th>Hora</th>
          <th>Acción</th>
        </tr>
      </thead>
      <tbody>
        <!-- Las filas se insertarán aquí con JavaScript -->
      </tbody>
    </table>
  </div>
</main>

<%@ include file="includes/footer.jsp" %>

<!-- Firebase SDKs -->
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-database-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-auth-compat.js"></script>

<script>
  // Configuración de Firebase
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

  const tabla = document.getElementById('tabla-citas').getElementsByTagName('tbody')[0];

  const ADMIN_EMAIL = "juanca.9738@gmail.com"; // Cambia a tu correo de admin

  firebase.auth().onAuthStateChanged((user) => {
    if (!user || user.email !== ADMIN_EMAIL) {
      alert("Acceso denegado. Solo el administrador puede ver esta página.");
      window.location.href = "index.jsp";
      return;
    }

    cargarCitas();

    // Mostrar saludo y ocultar "Iniciar sesión" si el usuario está logueado
    if (user.displayName) {
      const saludo = document.getElementById("saludoUsuario");
      if (saludo) saludo.textContent = `Hola ${user.displayName}`;
    }

    const loginBtn = document.getElementById("loginOption");
    if (loginBtn) loginBtn.style.display = "none";
  });

  function cargarCitas() {
    firebase.database().ref('citas').on('value', (snapshot) => {
      tabla.innerHTML = "";

      snapshot.forEach((childSnapshot) => {
        const cita = childSnapshot.val();
        const key = childSnapshot.key;

        const fila = tabla.insertRow();

        fila.insertCell().textContent = cita.nombre || "Sin nombre";
        fila.insertCell().textContent = cita.servicio || "N/A";
        fila.insertCell().textContent = cita.fecha || "N/A";
        fila.insertCell().textContent = cita.hora || "N/A";

        const celdaAccion = fila.insertCell();
        const btnEliminar = document.createElement("button");
        btnEliminar.className = "btn-eliminar";
        btnEliminar.textContent = "Eliminar";
        btnEliminar.onclick = () => eliminarCita(key);
        celdaAccion.appendChild(btnEliminar);
      });
    });
  }

  function eliminarCita(key) {
    if (confirm("¿Estás seguro de eliminar esta cita?")) {
      firebase.database().ref('citas/' + key).remove()
        .then(() => alert("✅ Cita eliminada."))
        .catch((error) => alert("❌ Error al eliminar: " + error.message));
    }
  }

  // Cerrar sesión desde el botón del header
  const logoutBtn = document.getElementById("btnLogout");
  if (logoutBtn) {
    logoutBtn.addEventListener("click", () => {
      firebase.auth().signOut().then(() => {
        alert("Has cerrado sesión.");
        window.location.href = "index.jsp";
      }).catch((error) => {
        alert("Error al cerrar sesión: " + error.message);
      });
    });
  }
</script>

</body>
</html>
