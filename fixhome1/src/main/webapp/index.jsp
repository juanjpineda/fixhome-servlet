<%@page import="java.time.Year"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Usuario"%>
<%@page import="util.Html"%>
<%@page import="dao.CrudServicio"%>
<%@page import="dao.CrudUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Usuario> profesionales = new ArrayList<>();
    for (Usuario u : new CrudUsuario().consultarUsuarios()) {
        if (Html.norm(u.getTipoUsuario()).equals("tecnico")) profesionales.add(u);
    }
    int totalServicios = new CrudServicio().consultarServicios().size();

    String[][] categorias = {
        {"Electricidad", "bi-lightning-charge", "Instalaciones y reparaciones eléctricas"},
        {"Plomería", "bi-droplet", "Fugas, tuberías y grifería"},
        {"Pintura", "bi-brush", "Interiores y exteriores"},
        {"Limpieza", "bi-stars", "Limpieza profunda del hogar"},
        {"Carpintería", "bi-hammer", "Muebles y arreglos en madera"},
        {"Cerrajería", "bi-key", "Cambio y apertura de cerraduras"},
        {"Aire acondicionado", "bi-snow", "Instalación y mantenimiento"},
        {"Electrodomésticos", "bi-plug", "Neveras, lavadoras y más"},
        {"Jardinería", "bi-flower1", "Cuidado de jardines y zonas verdes"},
        {"Remodelaciones", "bi-bricks", "Obra, acabados y reformas"}
    };
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FixHome | Profesionales para tu hogar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
<%@include file="menu.jsp" %>

<header class="hero-mk">
    <div class="container">
        <div class="row align-items-center g-4">
            <div class="col-lg-7">
                <h1>Todo lo que tu hogar necesita, <span>en un solo lugar.</span></h1>
                <p class="lead">Encuentra profesionales de confianza para reparar, instalar, mantener y transformar tu hogar. Compara opciones y conecta con el experto ideal.</p>

                <form action="buscar.jsp" method="GET" class="buscador" role="search">
                    <div class="campo">
                        <i class="bi bi-search"></i>
                        <input type="text" name="q" placeholder="Ej: plomería, pintura, limpieza..." aria-label="Buscar servicio">
                    </div>
                    <button type="submit" class="btn btn-naranja">Buscar profesionales</button>
                </form>

                <div class="chips">
                    <small class="me-1">Populares:</small>
                    <% for (int i = 0; i < 5; i++) { %>
                        <a href="buscar.jsp?q=<%= URLEncoder.encode(categorias[i][0], "UTF-8") %>"><%= categorias[i][0] %></a>
                    <% } %>
                </div>

                <% if (profesionales.size() > 0 || totalServicios > 0) { %>
                <div class="indicadores">
                    <% if (profesionales.size() > 0) { %>
                        <div><strong><%= profesionales.size() %></strong><span>profesionales registrados</span></div>
                    <% } %>
                    <% if (totalServicios > 0) { %>
                        <div><strong><%= totalServicios %></strong><span>servicios publicados</span></div>
                    <% } %>
                </div>
                <% } %>
            </div>

            <div class="col-lg-5 d-none d-lg-block">
                <div class="visual-hero" aria-hidden="true">
                    <div class="burbuja b1"><i class="bi bi-lightning-charge-fill"></i> Electricidad</div>
                    <div class="burbuja b2"><i class="bi bi-droplet-fill"></i> Plomería</div>
                    <div class="burbuja b3"><i class="bi bi-brush-fill"></i> Pintura</div>
                </div>
            </div>
        </div>
    </div>
</header>

<section class="container seccion">
    <h2>Categorías de servicios</h2>
    <p class="sub">Elige lo que necesitas y encuentra al profesional indicado</p>
    <div class="row g-3">
        <% for (String[] c : categorias) { %>
        <div class="col-6 col-md-4 col-lg-3">
            <a class="cat" href="buscar.jsp?q=<%= URLEncoder.encode(c[0], "UTF-8") %>">
                <i class="bi <%= c[1] %>"></i>
                <h6><%= c[0] %></h6>
                <p><%= c[2] %></p>
            </a>
        </div>
        <% } %>
    </div>
</section>

<section class="container seccion">
    <h2>Profesionales destacados</h2>
    <p class="sub">Técnicos registrados en FixHome</p>
    <% if (profesionales.isEmpty()) { %>
        <div class="vacio">
            <i class="bi bi-person-plus"></i>
            <h5>Aún no hay profesionales registrados</h5>
            <p>Sé el primero en ofrecer tus servicios en FixHome.</p>
            <a href="formularioUsuarios.jsp" class="btn btn-primary">Registrar un profesional</a>
        </div>
    <% } else { %>
        <div class="row g-4">
            <% int mostrados = 0;
               for (Usuario p : profesionales) {
                   if (mostrados++ == 6) break; %>
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
</section>

<section class="container seccion" id="como-funciona">
    <h2>Cómo funciona FixHome</h2>
    <p class="sub">Tres pasos para resolver lo que necesitas</p>
    <div class="row g-4 pasos">
        <div class="col-md-4">
            <div class="paso">
                <div class="numero">1</div>
                <i class="bi bi-search icono-paso"></i>
                <h5>Encuentra</h5>
                <p>Busca el servicio que necesitas por nombre o categoría.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="paso">
                <div class="numero">2</div>
                <i class="bi bi-people icono-paso"></i>
                <h5>Compara</h5>
                <p>Revisa los profesionales y sus perfiles.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="paso">
                <div class="numero">3</div>
                <i class="bi bi-chat-dots icono-paso"></i>
                <h5>Contacta</h5>
                <p>Coordina el trabajo directamente con el profesional.</p>
            </div>
        </div>
    </div>

    <div class="franja-cta">
        <h3>¿Eres profesional? Consigue clientes con FixHome</h3>
        <p>Regístrate y empieza a ofrecer tus servicios.</p>
        <a href="formularioUsuarios.jsp" class="btn btn-naranja">Quiero ofrecer mis servicios</a>
    </div>
</section>

<section class="container seccion" id="confianza">
    <h2>Confianza y seguridad</h2>
    <p class="sub">Lo que ya está disponible y lo que estamos construyendo</p>
    <div class="row g-3">
        <div class="col-md-6 col-lg-4"><div class="bloque-confianza"><i class="bi bi-person-lines-fill"></i> <span class="estado-badge ok">Disponible</span><h6>Perfiles de profesionales</h6><p>Registro de técnicos con sus datos de contacto.</p></div></div>
        <div class="col-md-6 col-lg-4"><div class="bloque-confianza"><i class="bi bi-card-checklist"></i> <span class="estado-badge ok">Disponible</span><h6>Información de servicios</h6><p>Cada servicio muestra su descripción y su precio.</p></div></div>
        <div class="col-md-6 col-lg-4"><div class="bloque-confianza"><i class="bi bi-star"></i> <span class="estado-badge pronto">Próximamente</span><h6>Opiniones de clientes</h6><p>Calificaciones y reseñas de los trabajos realizados.</p></div></div>
        <div class="col-md-6 col-lg-4"><div class="bloque-confianza"><i class="bi bi-chat-dots"></i> <span class="estado-badge pronto">Próximamente</span><h6>Comunicación directa</h6><p>Mensajes entre clientes y profesionales.</p></div></div>
        <div class="col-md-6 col-lg-4"><div class="bloque-confianza"><i class="bi bi-patch-check"></i> <span class="estado-badge pronto">Próximamente</span><h6>Verificación de identidad</h6><p>Insignia para profesionales verificados.</p></div></div>
        <div class="col-md-6 col-lg-4"><div class="bloque-confianza"><i class="bi bi-headset"></i> <span class="estado-badge pronto">Próximamente</span><h6>Reportes y soporte</h6><p>Canal para resolver inconvenientes.</p></div></div>
    </div>
</section>

<footer class="pie-grande" id="ayuda">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4">
                <h6><i class="bi bi-house-gear-fill text-warning"></i> FixHome</h6>
                <p class="small">Conectamos a las personas con profesionales de confianza para cuidar y transformar su hogar.</p>
            </div>
            <div class="col-6 col-lg-2">
                <h6>Navegación</h6>
                <a href="index.jsp">Inicio</a>
                <a href="buscar.jsp">Explorar servicios</a>
                <a href="index.jsp#como-funciona">Cómo funciona</a>
            </div>
            <div class="col-6 col-lg-2">
                <h6>Categorías</h6>
                <a href="buscar.jsp?q=Electricidad">Electricidad</a>
                <a href="buscar.jsp?q=Plomer%C3%ADa">Plomería</a>
                <a href="buscar.jsp?q=Pintura">Pintura</a>
            </div>
            <div class="col-6 col-lg-2">
                <h6>Clientes y profesionales</h6>
                <a href="formularioUsuarios.jsp">Crear cuenta</a>
                <a href="formularioUsuarios.jsp">Ofrecer mis servicios</a>
            </div>
            <div class="col-6 col-lg-2">
                <h6>Ayuda</h6>
                <a href="#">Contacto</a>
                <a href="#">Términos y condiciones</a>
                <a href="#">Política de privacidad</a>
            </div>
        </div>
        <div class="copy">© <%= Year.now() %> FixHome · Proyecto formativo SENA</div>
    </div>
</footer>
</body>
</html>