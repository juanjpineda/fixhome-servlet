package controlador;

import dao.CrudServicio;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvServicio", urlPatterns = {"/SvServicio"})
public class SvServicio extends HttpServlet {

    // GET: se usa para consultar. Redirige a la página que lista los servicios
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("consultarServicios.jsp");
    }

    // POST: registra o elimina, según el formulario que llegue
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Si el formulario pide eliminar, se atiende aquí y termina
        String accion = request.getParameter("accion");
        if ("eliminar".equals(accion)) {
            try {
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                boolean eliminado = new CrudServicio().eliminarServicio(idEliminar);
                response.sendRedirect("consultarServicios.jsp?msg=" + (eliminado ? "eliminado" : "error"));
            } catch (NumberFormatException e) {
                response.sendRedirect("consultarServicios.jsp?msg=error");
            }
            return;
        }

        // Registro de un servicio nuevo
        String mensaje;
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            double precio = Double.parseDouble(request.getParameter("precio"));

            boolean guardado = new CrudServicio()
                    .insertarServicio(id, nombre, descripcion, precio);

            mensaje = guardado
                    ? "Servicio registrado correctamente"
                    : "No fue posible registrar. El código ya existe";

        } catch (NumberFormatException e) {
            mensaje = "El código y el precio deben ser números";
        }

        request.setAttribute("mensaje", mensaje);
        request.getRequestDispatcher("formularioServicios.jsp").forward(request, response);
    }
}