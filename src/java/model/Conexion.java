/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    // Configuración de los parámetros de la BD
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/Frutixpress?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root"; // Cambia por tu usuario de MySQL
    private static final String PASS = "Martinez#044#"; // Cambia por tu contraseña de MySQL

    public static Connection obtenerConexion() {
        Connection con = null;
        try {
            Class.forName(DRIVER);
            con = DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            System.out.println("Error: No se encontró el Driver de MySQL -> " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Error: Falló la conexión a la base de datos -> " + e.getMessage());
        }
        return con;
    }
}
