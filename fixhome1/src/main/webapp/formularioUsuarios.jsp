<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <link rel="stylesheet" href="css/estilos.css">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registrar usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    
    <%@include file="menu.jsp" %>
    
<div class="container mt-5 col-md-6">
    <h1 class="text-center mb-4">Registrar usuario</h1>

    <form action="SvUsuario" method="POST">
        <div class="mb-3">
            <label class="form-label">Identificación</label>
            <input type="number" name="id" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" name="nombre" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Correo</label>
            <input type="email" name="correo" class="form-control">
        </div>
        <div class="mb-3">
            <label class="form-label">Teléfono</label>
            <input type="text" name="telefono" class="form-control">
        </div>
        <div class="mb-3">
            <label class="form-label">Tipo de usuario</label>
            <select name="tipoUsuario" class="form-select" required>
                <option value="">Seleccione...</option>
                <option value="Cliente">Cliente</option>
                <option value="Técnico">Técnico</option>
                <option value="Administrador">Administrador</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="SvUsuario" class="btn btn-secondary">Ver usuarios</a>
    </form>

    <%
        String mensaje = (String) request.getAttribute("mensaje");
        if (mensaje != null) {
    %>
        <div class="alert alert-info mt-3"><%= mensaje %></div>
    <% } %>
</div>
</body>
</html>