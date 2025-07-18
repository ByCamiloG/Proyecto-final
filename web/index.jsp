<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="includes/header.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <title>Inicio - Gildardo Gutiérrez</title>
    <link rel="stylesheet" href="styles.css">
</head>

<body>

<main class="index-page">
    <div class="index-overlay">
        <section class="hero-section">
            <div class="text-container">
                <h1>CORTE PERFECTO<br>LOOK IMPECABLE</h1>
                <p>Dare to be different with a style that only belongs to you.</p>

                <a href="agendar.jsp">
                    <button class="agenda-button">Agenda tu cita</button>
                </a>
            </div>
        </section>
    </div>
</main>

<%@ include file="includes/footer.jsp" %>

<!-- Firebase SDKs -->
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-auth-compat.js"></script>

<script>
  // Configuración de Firebase
  const firebaseConfig = {
    apiKey: "AIzaSyCDZvWq953WtoXTR-BvNDT-qiaocjrmeyM",
    authDomain: "peluqueriagildardo.firebaseapp.com",
    projectId: "peluqueriagildardo",
    storageBucket: "peluqueriagildardo.appspot.com",
    messagingSenderId: "585702751886",
    appId: "1:585702751886:web:41553292b19d9aa5cc13df",
    measurementId: "G-3RV5FX2GPN"
  };

  // Inicializar Firebase si aún no está
  if (!firebase.apps.length) {
    firebase.initializeApp(firebaseConfig);
  }

  // Verifica si el usuario está autenticado
  firebase.auth().onAuthStateChanged(user => {
    const contenedor = document.getElementById("cerrar-sesion-container");
    const saludo = document.getElementById("saludo-usuario");

    if (user) {
      const nombre = user.email ? user.email.split('@')[0] : "Usuario";
      saludo.textContent = `Hola, ${nombre}`;
      contenedor.style.display = "block";
    } else {
      contenedor.style.display = "none";
    }
  });

  // Función para cerrar sesión
  function cerrarSesion() {
    firebase.auth().signOut()
      .then(() => {
        window.location.href = "login.jsp";
      })
      .catch(error => {
        console.error("Error al cerrar sesión:", error);
      });
  }
</script>

</body>
</html>
