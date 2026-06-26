/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PedidoDAO {

    // Método para registrar la cabecera del pedido en la BD
    public boolean registrarPedido(PedidoVO pedido) {
        Connection con = null;
        PreparedStatement ps = null;
        boolean insertado = false;

        try {
            con = Conexion.obtenerConexion();
            String sql = "INSERT INTO pedido (fecha_pedido, estado_pedido, precio_total, id_carrito, id_repartidor) VALUES (?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            
            ps.setString(1, pedido.getFechaPedido());
            ps.setString(2, pedido.getEstadoPedido());
            ps.setDouble(3, pedido.getPrecioTotal());
            ps.setInt(4, pedido.getIdCarrito());
            
            if (pedido.getIdRepartidor() != null) {
                ps.setInt(5, pedido.getIdRepartidor());
            } else {
                ps.setNull(5, java.sql.Types.INTEGER);
            }

            if (ps.executeUpdate() > 0) {
                insertado = true;
            }
        } catch (SQLException e) {
            System.out.println("Error en PedidoDAO.registrarPedido: " + e.getMessage());
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (con != null) con.close(); } catch (SQLException e) {}
        }
        return insertado;
    }
}
