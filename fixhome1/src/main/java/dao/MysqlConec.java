package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MysqlConec {

    // Datos de conexión a MySQL
    private static final String USUARIO = "root";
    private static final String CONTRASENA = "admin2026";
    private static final String BD = "fixhome_db";
    private static final String IP = "localhost";
    private static final String PUERTO = "3306";

    // URL de conexión
    private static final String URL = "jdbc:mysql://" + IP + ":" + PUERTO + "/" + BD;

    private Connection conexion;

    // Abre la conexión y la retorna
    public Connection establecerConexion() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(URL, USUARIO, CONTRASENA);
        } catch (ClassNotFoundException e) {
            System.out.println("No se encontró el driver de MySQL. " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Error al conectar con la base de datos. " + e.getMessage());
        }
        return conexion;
    }

    // Cierra la conexión
    public void cerrarConexion() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
            }
        } catch (SQLException e) {
            System.out.println("No se pudo cerrar la conexión. " + e.getMessage());
        }
    }
}