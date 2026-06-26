/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ClienteDAO {

    // Método para validar si el correo y la contraseña existen
    public ClienteVO validarAcceso(String correo, String password) {
        ClienteVO cliente = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = Conexion.obtenerConexion();
            String sql = "SELECT * FROM cliente WHERE correo = ? AND contraseña = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, password);
            rs = ps.executeQuery();

            // Si encuentra coincidencia, mapea los datos al objeto VO
if (rs.next()) {
    cliente = new ClienteVO();
    cliente.setIdCliente(rs.getInt("id_cliente"));
    cliente.setNombre(rs.getString("nombre"));      // <- Corregido: rs.getString
    cliente.setCorreo(rs.getString("correo"));      // <- Corregido: rs.getString
    cliente.setDireccion(rs.getString("direccion"));  // <- Corregido: rs.getString
    cliente.setTelefono(rs.getString("telefono"));   // <- Corregido: rs.getString
    // No seteamos el password por seguridad
}
        } catch (SQLException e) {
            System.out.println("Error en ClienteDAO.validarAcceso: " + e.getMessage());
        } finally {
            // Cerramos recursos en orden inverso
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (con != null) con.close(); } catch (SQLException e) {}
        }
        return cliente; // Retorna null si las credenciales son inválidas
    }
}