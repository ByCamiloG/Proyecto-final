<%@ page contentType="text/html; charset=UTF-8" %>
<link href="https://fonts.googleapis.com/css2?family=Body+Grotesque&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/styles.css">

<header>
    <div class="logo">
        <a href="index.jsp">
            <img src="imagenes/gg-logo.png" alt="Logo Gildardo Gutiérrez">
        </a>
    </div>

    <nav>
        <ul>
            <li><a href="index.jsp">Inicio</a></li>
            <li><a href="productos.jsp">Productos</a></li>
            <li><a href="servicios.jsp">Servicios</a></li>
            <li><a href="contacto.jsp">Contacto</a></li>
        </ul>
    </nav>

    <div class="user-settings">
        <img src="imagenes/user-icon.png" alt="Perfil" id="user-menu">
    </div>
</header>

<!-- Menú desplegable -->
<div class="user-menu-dropdown" id="user-menu-dropdown">
  <ul>
    <li id="inicio-sesion-item"><a href="login.jsp">Iniciar sesión</a></li>
    <li><a href="admin.jsp">Mis citas</a></li>
    <li><a href="#" onclick="cerrarSesion()">Cerrar sesión</a></li>
  </ul>
</div>