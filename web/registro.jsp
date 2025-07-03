<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="includes/header.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <title>Registro - Gildardo Gutiérrez</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>

<main class="login-page">
  <div class="login-overlay">
    <div class="login-box">
      <h2>REGISTRO</h2>

      <input type="text" id="name" placeholder="Nombre completo" required>
      <input type="email" id="email" placeholder="Correo electrónico" required>
      <input type="password" id="password" placeholder="Contraseña" required>

      <button onclick="register()">Crear cuenta</button>

      <p><a href="login.jsp">¿Ya tienes cuenta?</a></p>
      <p id="register-message" style="margin-top: 10px; color: #f66;"></p>
    </div>
  </div>
</main>

<%@ include file="includes/footer.jsp" %>

<!-- Firebase SDK sin módulos -->
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/11.10.0/firebase-auth-compat.js"></script>

<script>
  // Configuración Firebase
  const firebaseConfig = {
    apiKey: "AIzaSyCDZvWq953WtoXTR-BvNDT-qiaocjrmeyM",
    authDomain: "peluqueriagildardo.firebaseapp.com",
    projectId: "peluqueriagildardo",
    storageBucket: "peluqueriagildardo.firebasestorage.app",
    messagingSenderId: "585702751886",
    appId: "1:585702751886:web:41553292b19d9aa5cc13df",
    measurementId: "G-3RV5FX2GPN"
  };

  // Inicializar Firebase
  firebase.initializeApp(firebaseConfig);

  // Función de registro
  function register() {
    const name = document.getElementById("name").value;
    const email = document.getElementById("email").value;
    const pass = document.getElementById("password").value;

    firebase.auth().createUserWithEmailAndPassword(email, pass)
      .then((userCredential) => {
        const user = userCredential.user;

        // Guardar el nombre del usuario en su perfil
        user.updateProfile({
          displayName: name
        }).then(() => {
          document.getElementById("register-message").style.color = "#4CAF50";
          document.getElementById("register-message").innerText = "¡Registro exitoso!";
          setTimeout(() => {
            window.location.href = "index.jsp";
          }, 1500);
        });
      })
      .catch((error) => {
        document.getElementById("register-message").innerText = error.message;
      });
  }
</script>

</body>
</html>
