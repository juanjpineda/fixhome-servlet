<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Usuario"%>
<%@page import="util.Html"%>
<%@page import="dao.CrudServicio"%>
<%@page import="dao.CrudUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Usuario> usuarios = new ArrayList<>(new CrudUsuario().consultarUsuarios());
    int tecnicos = 0;
    for (Usuario u : usuarios) {
        if (Html.norm(u.getTipoUsuario()).equals("tecnico")) tecnicos++;
    }
    int totalServicios = new CrudServicio().consultarServicios().size();

    usuarios.sort(Comparator.comparing(Usuario::getFechaRe).reversed());
    DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Panel | FixHome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
<%@include file="menu.jsp" %>

<div class="admin-layout">
    <aside class="sidebar">
        <h6>Administración</h6>
        <a href="admin.jsp" class="activo"><i class="bi bi-grid-1x2"></i> Resumen</a>
        <a href="SvUsuario"><i class="bi bi-people"></i> Usuarios</a>
        <a href="SvServicio"><i class="bi bi-tools"></i> Servicios</a>
        <a class="deshabilitado" aria-disabled="true"><i class="bi bi-person-workspace"></i> Profesionales <span class="estado-badge pronto">Pronto</span></a>
        <a class="deshabilitado" aria-disabled="true"><i class="bi bi-tags"></i> Categorías <span class="estado-badge pronto">Pronto</span></a>
        <a class="deshabilitado" aria-disabled="true"><i class="bi bi-inbox"></i> Solicitudes <span class="estado-badge pronto">Pronto</span></a>
        <a class="deshabilitado" aria-disabled="true"><i class="bi bi-star"></i> Reseñas <span class="estado-badge pronto">Pronto</span></a>
        <a class="deshabilitado" aria-disabled="true"><i class="bi bi-gear"></i> Configuración <span class="estado-badge pronto">Pronto</span></a>
    </aside>

    <main class="admin-main">
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h2>Resumen</h2>
                <small class="text-muted">Estado general de la plataforma</small>
            </div>
            <div>
                <a href="formularioUsuarios.jsp" class="btn btn-primary btn-sm"><i class="bi bi-person-plus"></i> Nuevo usuario</a>
                <a href="formularioServicios.jsp" class="btn btn-naranja btn-sm"><i class="bi bi-plus-circle"></i> Nuevo servicio</a>
            </div>
        </div>

        <div class="aviso-demo">
            <i class="bi bi-info-circle"></i> Modo demostración: el inicio de sesión y los permisos por rol aún no están implementados.
        </div>

        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-xl-3"><div class="stat"><div class="ico" style="background:#e8f0fb;color:#1e5aa8"><i class="bi bi-people-fill"></i></div><div><div class="num"><%= usuarios.size() %></div><small>Usuarios registrados</small></div></div></div>
            <div class="col-sm-6 col-xl-3"><div class="stat"><div class="ico" style="background:#ffedd5;color:#c2410c"><i class="bi bi-person-workspace"></i></div><div><div class="num"><%= tecnicos %></div><small>Profesionales (técnicos)</small></div></div></div>
            <div class="col-sm-6 col-xl-3"><div class="stat"><div class="ico" style="background:#dcfce7;color:#15803d"><i class="bi bi-tools"></i></div><div><div class="num"><%= totalServicios %></div><small>Servicios publicados</small></div></div></div>
            <div class="col-sm-6 col-xl-3"><div class="stat"><div class="ico" style="background:#f1f5f9;color:#64748b"><i class="bi bi-inbox"></i></div><div><div class="num">—</div><small>Solicitudes (próximamente)</small></div></div></div>
        </div>

        <div class="tabla-card">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
                <h5 class="m-0">Usuarios recientes</h5>
                <input type="search" id="filtro" class="form-control" style="max-width: 260px;" placeholder="Filtrar en la tabla..." aria-label="Filtrar">
            </div>

            <% if (usuarios.isEmpty()) { %>
                <div class="vacio">
                    <i class="bi bi-people"></i>
                    <h5>Aún no hay usuarios</h5>
                    <p>Registra el primero para verlo aquí.</p>
                    <a href="formularioUsuarios.jsp" class="btn btn-primary">Registrar usuario</a>
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table table-hover align-middle" id="recientes">
                        <thead><tr><th>Nombre</th><th>Tipo</th><th>Correo</th><th>Registro</th></tr></thead>
                        <tbody>
                        <% int n = 0;
                           for (Usuario u : usuarios) {
                               if (n++ == 8) break; %>
                            <tr>
                                <td><%= Html.esc(u.getNombre()) %></td>
                                <td><span class="badge-tipo tipo-<%= Html.norm(u.getTipoUsuario()) %>"><%= Html.esc(u.getTipoUsuario()) %></span></td>
                                <td><%= Html.esc(u.getCorreo()) %></td>
                                <td><%= u.getFechaRe().format(formato) %></td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
                <a href="SvUsuario" class="btn btn-secondary btn-sm mt-2">Ver todos los usuarios</a>
            <% } %>
        </div>
    </main>
</div>

<script>
var filtro = document.getElementById('filtro');
if (filtro) {
    filtro.addEventListener('input', function () {
        var t = filtro.value.toLowerCase();
        document.querySelectorAll('#recientes tbody tr').forEach(function (f) {
            f.style.display = f.textContent.toLowerCase().indexOf(t) > -1 ? '' : 'none';
        });
    });
}
</script>
</body>
</html>