<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="includes/header.jsp" %>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Productos - Gildardo Gutiérrez</title>
  <link rel="stylesheet" href="css/styles.css">
  <link href="https://fonts.googleapis.com/css2?family=Body+Grotesque&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

  <style>
    body {
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background-image: url("imagenes/salon-belleza.jpg");
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      color: #111;
    }

    h2 {
      text-align: center;
      color: #111;
    }

    .contenido {
      max-width: 1000px;
      margin: 100px auto;
      background-color: rgba(255, 255, 255, 0.95);
      padding: 30px;
      border-radius: 15px;
    }

    .producto-form {
      display: flex;
      flex-direction: column;
      gap: 10px;
      margin-bottom: 30px;
    }

    .producto-form input {
      padding: 10px;
      border-radius: 5px;
      border: 1px solid #ccc;
      color: #111;
    }

    .producto-form input::placeholder {
      color: #666;
    }

    .producto-form button {
      background-color: #222;
      color: white !important;
      padding: 12px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
    }

    .producto-form button:hover {
      background-color: #444;
    }

    .productos-container {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
      gap: 20px;
    }

    .producto-card {
      background-color: white;
      padding: 15px;
      border-radius: 10px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      text-align: center;
      color: #111;
    }

    .producto-card img {
      width: 100%;
      height: 150px;
      object-fit: cover;
      border-radius: 8px;
    }

    .producto-card h3 {
      margin: 10px 0 5px;
      color: #000;
    }

    .producto-card p {
      margin: 5px 0;
      color: #333;
    }

    .producto-card button {
      background-color: #c62828;
      color: white;
      border: none;
      padding: 8px 12px;
      border-radius: 5px;
      cursor: pointer;
      margin: 5px;
    }

    .producto-card button:hover {
      background-color: #b71c1c;
    }
  </style>
</head>
<body>

<!-- Contenido -->
<div class="contenido">
  <h2>Registrar nuevo producto</h2>
  <div class="producto-form">
    <input type="text" id="nombre" placeholder="Nombre del producto">
    <input type="text" id="descripcion" placeholder="Descripción">
    <input type="number" id="cantidad" placeholder="Cantidad">
    <input type="number" id="precio" placeholder="Precio">
    <input type="text" id="imagenURL" placeholder="URL de la imagen">
    <button onclick="guardarProducto()" id="btn-guardar">Guardar producto</button>
  </div>

  <h2>Lista de productos</h2>
  <div class="productos-container" id="lista-productos"></div>
</div>

<!-- Firebase compat scripts -->
<script src="https://www.gstatic.com/firebasejs/10.12.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.12.0/firebase-auth-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.12.0/firebase-database-compat.js"></script>

<script>
  const firebaseConfig = {
    apiKey: "AIzaSyCDZvWq953WtoXTR-BvNDT-qiaocjrmeyM",
    authDomain: "peluqueriagildardo.firebaseapp.com",
    databaseURL: "https://peluqueriagildardo-default-rtdb.firebaseio.com/",
    projectId: "peluqueriagildardo",
    storageBucket: "peluqueriagildardo.appspot.com",
    messagingSenderId: "585702751886",
    appId: "1:585702751886:web:41553292b19d9aa5cc13df"
  };

  firebase.initializeApp(firebaseConfig);
  const database = firebase.database();

  let editandoClave = null;

  function guardarProducto() {
    const user = firebase.auth().currentUser;

    if (!user || user.email !== "juanca.9738@gmail.com") {
      alert("Solo el administrador puede guardar productos.");
      return;
    }

    const nombre = document.getElementById("nombre").value;
    const descripcion = document.getElementById("descripcion").value;
    const cantidad = document.getElementById("cantidad").value;
    const precio = document.getElementById("precio").value;
    const imagenURL = document.getElementById("imagenURL").value;

    const producto = { nombre, descripcion, cantidad, precio, imagenURL };

    if (editandoClave) {
      database.ref('productos/' + editandoClave).update(producto).then(() => {
        alert("Producto actualizado");
        resetFormulario();
        cargarProductos();
      });
    } else {
      database.ref('productos').push(producto).then(() => {
        alert("Producto guardado");
        resetFormulario();
        cargarProductos();
      });
    }
  }

  function resetFormulario() {
    document.querySelector(".producto-form").reset();
    document.getElementById("btn-guardar").textContent = "Guardar producto";
    editandoClave = null;
  }

  function cargarProductos() {
    const contenedor = document.getElementById('lista-productos');
    contenedor.innerHTML = '';

    database.ref('productos').once('value', function(snapshot) {
      const productos = [];

      snapshot.forEach(function(childSnapshot) {
        const producto = childSnapshot.val();
        producto._clave = childSnapshot.key;
        productos.push(producto);
      });

      productos.sort((a, b) => a.nombre.toLowerCase().localeCompare(b.nombre.toLowerCase()));

      productos.forEach(producto => {
        const clave = producto._clave;

        const card = document.createElement('div');
        card.className = 'producto-card';

        const img = document.createElement('img');
        img.src = producto.imagenURL || 'imagenes/default.png';
        img.alt = producto.nombre || 'Sin nombre';

        const nombre = document.createElement('h3');
        nombre.textContent = producto.nombre || 'Sin nombre';

        const descripcion = document.createElement('p');
        descripcion.textContent = producto.descripcion || 'Sin descripción';

        const cantidad = document.createElement('p');
        cantidad.textContent = 'Cantidad: ' + (producto.cantidad || '0');

        const precio = document.createElement('p');
        precio.textContent = 'Precio: $' + (producto.precio || '0');

        card.appendChild(img);
        card.appendChild(nombre);
        card.appendChild(descripcion);
        card.appendChild(cantidad);
        card.appendChild(precio);

        const user = firebase.auth().currentUser;
        if (user && user.email === "juanca.9738@gmail.com") {
          const btnEditar = document.createElement('button');
          btnEditar.textContent = 'Editar';
          btnEditar.onclick = () => {
            document.getElementById("nombre").value = producto.nombre;
            document.getElementById("descripcion").value = producto.descripcion;
            document.getElementById("cantidad").value = producto.cantidad;
            document.getElementById("precio").value = producto.precio;
            document.getElementById("imagenURL").value = producto.imagenURL;
            document.getElementById("btn-guardar").textContent = "Actualizar producto";
            editandoClave = clave;
          };

          const btnEliminar = document.createElement('button');
          btnEliminar.textContent = 'Eliminar';
          btnEliminar.onclick = () => {
            database.ref('productos/' + clave).remove().then(() => {
              alert('Producto eliminado');
              cargarProductos();
            });
          };

          card.appendChild(btnEditar);
          card.appendChild(btnEliminar);
        }

        contenedor.appendChild(card);
      });
    });
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

<%@ include file="includes/footer.jsp" %>
</body>
</html>
