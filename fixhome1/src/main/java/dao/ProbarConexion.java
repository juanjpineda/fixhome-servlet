package dao;

import java.sql.Connection;

public class ProbarConexion {
    public static void main(String[] args) {
        Connection cn = new MysqlConec().establecerConexion();
        if (cn != null) {
            System.out.println("Conexión exitosa a fixhome_db");
        } else {
            System.out.println("No se pudo conectar");
        }
    }
}