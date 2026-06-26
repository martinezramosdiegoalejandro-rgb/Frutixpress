/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DetalleCarritoDAO {

    // Método para insertar un nuevo producto al carrito en la BD
    public boolean agregarProductoAlCarrito(DetalleCarritoVO detalle) {
        Connection con = null;
        PreparedStatement ps = null;
        boolean insertado = false;

        try {
            con = Conexion.obtenerConexion();
            // CORRECCIÓN: Si ya existe el producto en el carrito, se suma la nueva cantidad
            String sql = "INSERT INTO detalleCarrito (id_producto, id_carrito, cantidad, precio_unitario) "
                       + "VALUES (?, ?, ?, ?) "
                       + "ON DUPLICATE KEY UPDATE cantidad = cantidad + ?";
            
            ps = con.prepareStatement(sql);
            
            ps.setInt(1, detalle.getIdProducto());
            ps.setInt(2, detalle.getIdCarrito());
            ps.setDouble(3, detalle.getCantidad());
            ps.setDouble(4, detalle.getPrecioUnitario());
            ps.setDouble(5, detalle.getCantidad()); // Este mapea al último '?' para la actualización

            if (ps.executeUpdate() > 0) {
                insertado = true;
            }
        } catch (java.sql.SQLException e) {
            System.out.println("Error en DetalleCarritoDAO.agregarProductoAlCarrito: " + e.getMessage());
        } finally {
            try { if (ps != null) ps.close(); } catch (java.sql.SQLException e) {}
            try { if (con != null) con.close(); } catch (java.sql.SQLException e) {}
        }
        return insertado;
    }
}
