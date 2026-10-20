<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Servicio"%>
<%@page import="modelos.Usuario"%>
<%@page import="util.Html"%>
<%@page import="dao.CrudServicio"%>
<%@page import="dao.CrudUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String q = request.getParameter("q");
    if (q == null) q = "";
    q = q.trim();
    String qn = Html.norm(q);

    List<Servicio> servicios = new ArrayList<>();
    for (Servicio s : new CrudServicio().consultarServicios()) {
        if (qn.isEmpty() || Html.norm(s.getNombre()).contains(qn) || Html.norm(s.getDescripcion()).contains(qn)) {
            servicios.add(s);
        }
    }
    List<Usuario> profesionales = new ArrayList<>();
    for (Usuario u : new CrudUsuario().consultarUsuarios()) {
        if (Html.norm(u.getTipoUsuario()).equals("tecnico")
                && (qn.isEmpty() || Html.norm(u.getNombre()).contains(qn))) {
            profesionales.add(u);
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Explorar | FixHome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
<%@include file="menu.jsp" %>

<div class="container my-5">
    <h1 class="text-center mb-4">Explorar</h1>

    <form action="buscar.jsp" method="GET" class="buscador" role="search" style="box-shadow: 0 8px 30px rgba(15,42,71,.1); padding: .6rem;">
        <div class="campo">
            <i class="bi bi-search"></i>
            <input type="text" name="q" value="<%= Html.esc(q) %>" placeholder="Buscar servicio o profesional" aria-label="Buscar">
        </div>
        <button type="submit" class="btn btn-naranja">Buscar</button>
    </form>

    <h4 class="mt-5 mb-3">Servicios <span class="text-muted fs-6">(<%= servicios.size() %>)</span></h4>
    <% if (servicios.isEmpty()) { %>
        <div class="vacio">
            <i class="bi bi-search"></i>
            <h5>No encontramos servicios<%= q.isEmpty() ? "" : " para \"" + Html.esc(q) + "\"" %></h5>
            <p>Prueba con otra palabra o registra un servicio nuevo.</p>
            <a href="formularioServicios.jsp" class="btn btn-primary">Registrar servicio</a>
        </div>
    <% } else { %>
        <div class="row g-3">
            <% for (Servicio s : servicios) { %>
            <div class="col-md-6 col-lg-4">
                <div class="pro text-start">
                    <h5><%= Html.esc(s.getNombre()) %></h5>
                    <p class="text-muted"><%= Html.esc(s.getDescripcion()) %></p>
                    <strong class="precio">$ <%= String.format("%,.2f", s.getPrecio()) %></strong>
                </div>
            </div>
            <% } %>
        </div>
    <% } %>

    <h4 class="mt-5 mb-3" id="profesionales">Profesionales <span class="text-muted fs-6">(<%= profesionales.size() %>)</span></h4>
    <% if (profesionales.isEmpty()) { %>
        <div class="vacio">
            <i class="bi bi-person-plus"></i>
            <h5>No hay profesionales para mostrar</h5>
            <p>Registra técnicos para que aparezcan aquí.</p>
            <a href="formularioUsuarios.jsp" class="btn btn-primary">Registrar profesional</a>
        </div>
    <% } else { %>
        <div class="row g-3">
            <% for (Usuario p : profesionales) { %>
            <div class="col-md-6 col-lg-4">
                <div class="pro">
                    <div class="avatar"><%= Html.esc(p.getNombre().substring(0, 1).toUpperCase()) %></div>
                    <h5><%= Html.esc(p.getNombre()) %></h5>
                    <p class="text-muted mb-3">Técnico</p>
                    <button class="btn btn-secondary btn-sm" disabled title="Próximamente">Ver perfil</button>
                    <button class="btn btn-primary btn-sm" disabled title="Próximamente">Solicitar servicio</button>
                </div>
            </div>
            <% } %>
        </div>
    <% } %>
</div>
</body>
</html>