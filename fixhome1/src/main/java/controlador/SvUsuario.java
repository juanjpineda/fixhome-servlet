package controlador;

import dao.CrudUsuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvUsuario", urlPatterns = {"/SvUsuario"})
public class SvUsuario extends HttpServlet {

    // GET: se usa para consultar. Redirige a la página que lista los usuarios
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("consultarUsuarios.jsp");
    }

    // POST: recibe los datos del formulario y los guarda en la base de datos
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String mensaje;
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");
            String tipoUsuario = request.getParameter("tipoUsuario");

            boolean guardado = new CrudUsuario()
                    .insertarUsuario(id, nombre, correo, telefono, tipoUsuario);

            mensaje = guardado
                    ? "Usuario registrado correctamente"
                    : "No fue posible registrar. La identificación ya existe";

        } catch (NumberFormatException e) {
            mensaje = "La identificación debe ser un número";
        }

        request.setAttribute("mensaje", mensaje);
        request.getRequestDispatcher("formularioUsuarios.jsp").forward(request, response);
    }
}