# Gildardo Gutiérrez Peluquería

Plataforma web para la gestión integral de una peluquería moderna, que combina reserva de citas, simulación de cortes mediante IA, gestión de productos y contacto directo con los clientes. Desarrollado como proyecto académico de la Universidad Nacional de Colombia utilizando tecnologías como JSP, Firebase y Java. La url del proyecto es: https://proyecto-final-06gi.onrender.com el servidor si no muestra la pagina es por que se esta iniciando 

# 📌 Características principales

- Registro e inicio de sesión con Firebase Authentication (correo y contraseña).
- Agendamiento de citas: los clientes pueden elegir fecha, hora y tipo de servicio.
- Panel administrativo: incluye listado y eliminación de citas, además de gestión CRUD de productos.
- Simulación de cortes con IA: carga de imagen y aplicación de estilo mediante la API de Replicate a través de un servlet Java.
- Sección de contacto: formulario y mapa integrado de ubicación.
- Responsive y accesible desde navegadores modernos en desktop y móviles.

# 🛠️ Tecnología empleada
- Frontend: JSP, HTML5, CSS3, JavaScript.
- Backend: Servlets Java (GenerarCorteServlet) + Firebase Realtime Database.
- Autenticación: Firebase Auth.
- Simulación de imágenes: API de Replicate con modelo de IA.
- Servidor de aplicaciones: Apache Tomcat (Java 8+).
- Control de versiones: Git

# 🔧 Uso

- Registro/Login: los usuarios se registran con correo y contraseña.
- Agendar cita: los clientes ingresan sus datos, eligen fecha y servicio.
- Panel de administrador: acceso exclusivo para el correo del administrador (ej: juanca.9738@gmail.com).
- Productos: los productos se gestionan desde productos.jsp (solo admin).
- Simulación de cortes IA: los usuarios pueden subir una foto y visualizar un nuevo estilo.
- Formulario de contacto: disponible para todos los visitantes.

# 🧪 Pruebas

- Verificar funcionamiento de inicio de sesión y flujo de usuario.
- Validar que las citas se almacenen correctamente en Firebase.
- Confirmar que las imágenes generadas por la IA se visualicen correctamente.
- Asegurar que las funcionalidades de CRUD en productos estén restringidas al administrador.

# 📁 Estructura del proyecto

/Web Pages
├── META-INF/
│   └── context.xml
├── WEB-INF/
│   └── web.xml (si lo tienes configurado)
├── css/
│   └── styles.css
├── imagenes/
│   ├── contacto.jpg
│   ├── facebook.png
│   ├── gg-logo.png
│   ├── instagram.png
│   ├── salon-belleza.jpg
│   ├── user-icon.png
│   └── whatsapp.png
├── includes/
│   ├── footer.jsp
│   └── header.jsp
├── js/
│   └── script.js
├── admin.jsp
├── agendar.jsp
├── ajustes.jsp
├── contacto.jsp
├── index.jsp
├── login.jsp
├── perfil.jsp
├── productos.jsp
├── registro.jsp
└── servicios.jsp

/Source Packages
└── com.gildardo/
    └── GenerarCorteServlet.java

/Libraries
├── json-20240303.jar
├── okhttp-4.9.3.jar
├── okio-2.8.0.jar
├── gson-2.10.1.jar
├── kotlin-stdlib-*.jar
└── json-20210307.jar

/Servidor
└── Apache Tomcat o TomEE configurado

/JDK
└── JDK 24 (Default)
