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
    
    public ClienteVO validarLogin(String correo, String password) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ClienteVO cliente = null;
        
        // CORRECCIÓN: Cambiado 'password' por 'contraseña' para que coincida con tu MySQL
        String sql = "SELECT * FROM cliente WHERE TRIM(correo) = TRIM(?) AND TRIM(contraseña) = TRIM(?)";
        
        System.out.println("=== INTENTO DE LOGUEO ===");
        System.out.println("Digitado Correo: [" + correo + "]");
        System.out.println("Digitado Password: [" + password + "]");
        
        try {
            con = Conexion.obtenerConexion();
            sql = "SELECT * FROM cliente WHERE correo = ? AND contraseña = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, password);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                cliente = new ClienteVO();
                cliente.setIdCliente(rs.getInt("id_cliente"));
                cliente.setNombre(rs.getString("nombre"));
                cliente.setCorreo(rs.getString("correo"));
                cliente.setDireccion(rs.getString("direccion"));
                cliente.setTelefono(rs.getString("telefono"));
                
                System.out.println("-> ¡USUARIO ENCONTRADO EXITOSAMENTE EN BD!: " + cliente.getNombre());
            } else {
                System.out.println("-> error: La base de datos devolvió 0 coincidencias.");
            }
        } catch (SQLException e) {
            System.out.println("-> EXCEPCIÓN SQL EN ClienteDAO.validarLogin: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (con != null) con.close(); } catch (SQLException e) {}
        }
        return cliente;
    }
    
    public boolean registrarCliente(ClienteVO cliente) {
        Connection con = null;
        PreparedStatement ps = null;
        boolean registrado = false;
        
        // Ajustado exactamente a las columnas que maneja tu objeto VO y tu tabla
        String sql = "INSERT INTO cliente (nombre, correo, contraseña, direccion, telefono) VALUES (?, ?, ?, ?, ?)";
        
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(sql);
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getCorreo());
            ps.setString(3, cliente.getContraseña()); 
            ps.setString(4, cliente.getDireccion());
            ps.setString(5, cliente.getTelefono());
            
            if (ps.executeUpdate() > 0) {
                registrado = true;
            }
        } catch (SQLException e) {
            System.out.println("Error en ClienteDAO.registrarCliente: " + e.getMessage());
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (con != null) con.close(); } catch (SQLException e) {}
        }
        return registrado;
    }
    
    public boolean actualizarContraseña(String correo, String nuevaContraseña) {
        Connection con = null;
        PreparedStatement ps = null;
        boolean actualizado = false;
        
        // Sentencia SQL para actualizar la clave si el correo coincide
        String sql = "UPDATE cliente SET contraseña = ? WHERE TRIM(correo) = TRIM(?)";
        
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(sql);
            ps.setString(1, nuevaContraseña);
            ps.setString(2, correo);
            
            // executeUpdate devuelve el número de filas afectadas
            if (ps.executeUpdate() > 0) {
                actualizado = true;
            }
        } catch (SQLException e) {
            System.out.println("Error en ClienteDAO.actualizarContraseña: " + e.getMessage());
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (con != null) con.close(); } catch (SQLException e) {}
        }
        return actualizado;
    }
}