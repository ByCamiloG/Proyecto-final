# Gildardo Gutiérrez Peluquería

Plataforma web para la gestión integral de una peluquería moderna, que combina reserva de citas, simulación de cortes mediante IA, gestión de productos y contacto directo con los clientes. Desarrollado como proyecto académico de la Universidad Nacional de Colombia utilizando tecnologías como JSP, Firebase y Java. La url del proyecto es: https://proyecto-final-06gi.onrender.com el servidor si no muestra la pagina es por que se esta iniciando ya que esta se encuentra alojada en render y este servicio se suspende por inactividad

# 📌 Características principales

- Registro e inicio de sesión con Firebase Authentication (correo: Juanca.9738@gmail.com y contraseña: Camilo123 este usuario tiene los parametros admin).
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

/Web Pages <br>
├── META-INF/ <br>
│   └── context.xml <br>
├── WEB-INF/ <br>
│   └── web.xml (si lo tienes configurado) <br>
├── css/ <br>
│   └── styles.css <br>
├── imagenes/ <br>
│   ├── contacto.jpg <br>
│   ├── facebook.png <br>
│   ├── gg-logo.png <br>
│   ├── instagram.png <br>
│   ├── salon-belleza.jpg <br>
│   ├── user-icon.png <br>
│   └── whatsapp.png <br>
├── includes/ <br>
│   ├── footer.jsp <br>
│   └── header.jsp <br>
├── js/ <br>
│   └── script.js <br>
├── admin.jsp <br>
├── agendar.jsp <br>
├── ajustes.jsp <br>
├── contacto.jsp <br>
├── index.jsp <br>
├── login.jsp <br>
├── perfil.jsp <br>
├── productos.jsp <br>
├── registro.jsp <br>
└── servicios.jsp <br>

/Source Packages <br>
└── com.gildardo/ <br>
    └── GenerarCorteServlet.java <br>

/Libraries <br>
├── json-20240303.jar <br>
├── okhttp-4.9.3.jar <br>
├── okio-2.8.0.jar <br>
├── gson-2.10.1.jar <br>
├── kotlin-stdlib-*.jar <br>
└── json-20210307.jar <br>

/Servidor <br>
└── Apache Tomcat o TomEE configurado <br>

/JDK <br>
└── JDK 24 (Default) <br>

# 📷 Vista previa
<img width="1851" height="956" alt="image" src="https://github.com/user-attachments/assets/acfeea05-dd76-478f-b4d0-31d4e0d9fe05" />
<img width="1853" height="954" alt="image" src="https://github.com/user-attachments/assets/ba1c9c8e-9701-45de-abf3-3f6a40d5609c" />
<img width="1856" height="950" alt="image" src="https://github.com/user-attachments/assets/4bfdc224-9460-4bf4-87f2-813e2b3a559c" />
<img width="1854" height="958" alt="image" src="https://github.com/user-attachments/assets/3795ba0d-a65d-4a56-8f33-a42d5e332ad2" />




