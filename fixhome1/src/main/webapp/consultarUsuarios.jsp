<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Usuario"%>
<%@page import="dao.CrudUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <link rel="stylesheet" href="css/estilos.css">
    
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Usuarios</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.5/css/dataTables.bootstrap5.css"/>
</head>
<body>
    
    <%@include file="menu.jsp" %>
    
<div class="container mt-5">
    <h1 class="text-center mb-4">Lista de usuarios</h1>
    <a href="formularioUsuarios.jsp" class="btn btn-primary mb-3">Nuevo usuario</a>
    <a href="index.jsp" class="btn btn-secondary mb-3">Inicio</a>

    <table id="tabla" class="table table-striped">
        <thead>
            <tr>
                <th>Identificación</th>
                <th>Nombre</th>
                <th>Correo</th>
                <th>Teléfono</th>
                <th>Tipo</th>
                <th>Fecha de registro</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<Usuario> lista = new CrudUsuario().consultarUsuarios();
            DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            for (Usuario u : lista) {
        %>
            <tr>
                <td><%= u.getId() %></td>
                <td><%= u.getNombre() %></td>
                <td><%= u.getCorreo() %></td>
                <td><%= u.getTelefono() %></td>
                <td><%= u.getTipoUsuario() %></td>
                <td><%= u.getFechaRe().format(formato) %></td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/2.3.5/js/dataTables.js"></script>
<script src="https://cdn.datatables.net/2.3.5/js/dataTables.bootstrap5.js"></script>
<script>new DataTable('#tabla');</script>
</body>
</html>