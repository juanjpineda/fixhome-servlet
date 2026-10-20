<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar-fixhome">
    <div class="container nav-inner">
        <a class="marca" href="index.jsp"><i class="bi bi-house-gear-fill"></i> FixHome</a>

        <button class="nav-toggle" type="button" aria-label="Abrir menú" aria-expanded="false" aria-controls="navFix">
            <i class="bi bi-list"></i>
        </button>

        <div class="nav-collapse" id="navFix">
            <div class="enlaces">
                <a href="index.jsp">Inicio</a>
                <a href="buscar.jsp">Explorar servicios</a>
                <a href="buscar.jsp#profesionales">Profesionales</a>
                <a href="index.jsp#como-funciona">Cómo funciona</a>
                <a href="index.jsp#ayuda">Ayuda</a>
                <a href="admin.jsp">Panel</a>
            </div>
            <div class="acciones">
                <span class="btn-ghost disabled" title="Próximamente" aria-disabled="true">Iniciar sesión</span>
                <a class="btn btn-naranja btn-sm" href="formularioUsuarios.jsp">Registrarse</a>
            </div>
        </div>
    </div>
</nav>
<script>
(function () {
    var b = document.querySelector('.nav-toggle');
    var n = document.getElementById('navFix');
    b.addEventListener('click', function () {
        var abierto = n.classList.toggle('abierto');
        b.setAttribute('aria-expanded', abierto);
    });
})();
</script>