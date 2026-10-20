<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <link rel="stylesheet" href="css/estilos.css">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registrar servicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@include file="menu.jsp" %>
    
<div class="container mt-5 col-md-6">
    <h1 class="text-center mb-4">Registrar servicio</h1>

    <form action="SvServicio" method="POST">
        <div class="mb-3">
            <label class="form-label">Código</label>
            <input type="number" name="id" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Nombre del servicio</label>
            <input type="text" name="nombre" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Descripción</label>
            <input type="text" name="descripcion" class="form-control">
        </div>
        <div class="mb-3">
            <label class="form-label">Precio</label>
            <input type="number" name="precio" step="0.01" min="0" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="SvServicio" class="btn btn-secondary">Ver servicios</a>
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