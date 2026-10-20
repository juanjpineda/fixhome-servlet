package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelos.Usuario;

public class CrudUsuario {

    // INSERTAR: guarda un usuario en la tabla usuario
    public boolean insertarUsuario(int id, String nombre, String correo,
                                   String telefono, String tipoUsuario) {
        String sql = "INSERT INTO usuario (id_usuario, nombre, correo, telefono, tipoUsuario) "
                   + "VALUES (?, ?, ?, ?, ?)";
        try (Connection cn = new MysqlConec().establecerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setString(2, nombre);
            ps.setString(3, correo);
            ps.setString(4, telefono);
            ps.setString(5, tipoUsuario);

            return ps.executeUpdate() > 0;

        } catch (SQLException | NullPointerException e) {
            System.out.println("Error al insertar usuario: " + e.getMessage());
            return false;
        }
    }

    // CONSULTAR: devuelve la lista de todos los usuarios
    public List<Usuario> consultarUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuario";
        try (Connection cn = new MysqlConec().establecerConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id_usuario"));
                u.setNombre(rs.getString("nombre"));
                u.setCorreo(rs.getString("correo"));
                u.setTelefono(rs.getString("telefono"));
                u.setTipoUsuario(rs.getString("tipoUsuario"));
                u.setFechaRe(rs.getTimestamp("fechaRegistro").toLocalDateTime());
                lista.add(u);
            }

        } catch (SQLException | NullPointerException e) {
            System.out.println("Error al consultar usuarios: " + e.getMessage());
        }
        return lista;
    }
}