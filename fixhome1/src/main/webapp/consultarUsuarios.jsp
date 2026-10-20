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

    <%
        String msg = request.getParameter("msg");
        if ("eliminado".equals(msg)) {
    %>
        <div class="alert alert-success">Usuario eliminado correctamente</div>
    <% } else if ("error".equals(msg)) { %>
        <div class="alert alert-danger">No fue posible eliminar el usuario</div>
    <% } %>
    
    <table id="tabla" class="table table-striped">
        <thead>
            <tr>
                <th>Identificación</th>
                <th>Nombre</th>
                <th>Correo</th>
                <th>Teléfono</th>
                <th>Tipo</th>
                <th>Fecha de registro</th>
                <th>Acciones</th>
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
                <td>
                    <form action="SvUsuario" method="POST" class="d-inline"
                          onsubmit="return confirm('¿Seguro que deseas eliminar este usuario?');">
                        <input type="hidden" name="accion" value="eliminar">
                        <input type="hidden" name="id" value="<%= u.getId() %>">
                        <button type="submit" class="btn btn-sm btn-outline-danger">
                            <i class="bi bi-trash"></i> Eliminar
                        </button>
                    </form>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/2.3.5/js/dataTables.js"></script>
<script src="https://cdn.datatables.net/2.3.5/js/dataTables.bootstrap5.js"></script>
<script>
new DataTable('#tabla', {
    columnDefs: [{ orderable: false, targets: -1 }],
    language: {
        search: 'Buscar:',
        lengthMenu: 'Mostrar _MENU_ registros',
        info: 'Mostrando _START_ a _END_ de _TOTAL_ registros',
        infoEmpty: 'Sin registros',
        emptyTable: 'No hay datos registrados',
        zeroRecords: 'No se encontraron resultados',
        paginate: { first: 'Primero', last: 'Último', next: 'Siguiente', previous: 'Anterior' }
    }
});
</script>
</body>
</html>