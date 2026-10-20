<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Servicio"%>
<%@page import="dao.CrudServicio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <link rel="stylesheet" href="css/estilos.css">
    
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Servicios</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.5/css/dataTables.bootstrap5.css"/>
</head>
<body>
    
    <%@include file="menu.jsp" %>
    
<div class="container mt-5">
    <h1 class="text-center mb-4">Lista de servicios</h1>
    <a href="formularioServicios.jsp" class="btn btn-primary mb-3">Nuevo servicio</a>
    <a href="index.jsp" class="btn btn-secondary mb-3">Inicio</a>

    <table id="tabla" class="table table-striped">
        <thead>
            <tr>
                <th>Código</th>
                <th>Nombre</th>
                <th>Descripción</th>
                <th>Precio</th>
                <th>Fecha de registro</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<Servicio> lista = new CrudServicio().consultarServicios();
            DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            for (Servicio s : lista) {
        %>
            <tr>
                <td><%= s.getId() %></td>
                <td><%= s.getNombre() %></td>
                <td><%= s.getDescripcion() %></td>
                <td>$ <%= String.format("%,.2f", s.getPrecio()) %></td>
                <td><%= s.getFechaRe().format(formato) %></td>
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