package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelos.Servicio;

public class CrudServicio {

    // INSERTAR: guarda un servicio en la tabla servicio
    public boolean insertarServicio(int id, String nombre, String descripcion, double precio) {
        String sql = "INSERT INTO servicio (id_servicio, nombre, descripcion, precio) "
                   + "VALUES (?, ?, ?, ?)";
        try (Connection cn = new MysqlConec().establecerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setString(2, nombre);
            ps.setString(3, descripcion);
            ps.setDouble(4, precio);

            return ps.executeUpdate() > 0;

        } catch (SQLException | NullPointerException e) {
            System.out.println("Error al insertar servicio: " + e.getMessage());
            return false;
        }
    }

    // CONSULTAR: devuelve la lista de todos los servicios
    public List<Servicio> consultarServicios() {
        List<Servicio> lista = new ArrayList<>();
        String sql = "SELECT * FROM servicio";
        try (Connection cn = new MysqlConec().establecerConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Servicio s = new Servicio();
                s.setId(rs.getInt("id_servicio"));
                s.setNombre(rs.getString("nombre"));
                s.setDescripcion(rs.getString("descripcion"));
                s.setPrecio(rs.getDouble("precio"));
                s.setFechaRe(rs.getTimestamp("fechaRegistro").toLocalDateTime());
                lista.add(s);
            }

        } catch (SQLException | NullPointerException e) {
            System.out.println("Error al consultar servicios: " + e.getMessage());
        }
        return lista;
    }

    // ELIMINAR: borra un servicio por su código
    public boolean eliminarServicio(int id) {
        String sql = "DELETE FROM servicio WHERE id_servicio = ?";
        try (Connection cn = new MysqlConec().establecerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException | NullPointerException e) {
            System.out.println("Error al eliminar servicio: " + e.getMessage());
            return false;
        }
    }
}