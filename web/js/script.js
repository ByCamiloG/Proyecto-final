// Esperar a que el DOM esté completamente cargado
document.addEventListener('DOMContentLoaded', function () {
    const userMenu = document.getElementById('user-menu');
    const dropdown = document.getElementById('user-menu-dropdown');

    if (userMenu && dropdown) {
        userMenu.addEventListener('click', function () {
            dropdown.style.display = (dropdown.style.display === 'block') ? 'none' : 'block';
        });

        // Cierra el menú si haces clic fuera de él
        document.addEventListener('click', function (e) {
            if (!dropdown.contains(e.target) && e.target !== userMenu) {
                dropdown.style.display = 'none';
            }
        });
    }
});
