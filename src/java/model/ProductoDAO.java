/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    public List<ProductoVO> listarProductos() {
        List<ProductoVO> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = Conexion.obtenerConexion();
            String sql = "SELECT id_producto, nombre, descripcion, precio, stock FROM producto";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductoVO prod = new ProductoVO();
                prod.setIdProducto(rs.getInt("id_producto"));
                prod.setNombre(rs.getString("nombre"));
                prod.setDescripcion(rs.getString("descripcion"));
                prod.setPrecio(rs.getDouble("precio"));
                prod.setStock(rs.getDouble("stock"));
                lista.add(prod);
            }
        } catch (SQLException e) {
            System.out.println("Error en ProductoDAO.listarProductos: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (con != null) con.close(); } catch (SQLException e) {}
        }
        return lista;
    }
    // Método para buscar un producto específico por su ID
public ProductoVO buscarPorId(int id) {
    ProductoVO prod = null;
    java.sql.Connection con = null;
    java.sql.PreparedStatement ps = null;
    java.sql.ResultSet rs = null;

    try {
        con = Conexion.obtenerConexion();
        String sql = "SELECT id_producto, nombre, descripcion, precio, stock FROM producto WHERE id_producto = ?";
        ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {
            prod = new ProductoVO();
            prod.setIdProducto(rs.getInt("id_producto"));
            prod.setNombre(rs.getString("nombre"));
            prod.setDescripcion(rs.getString("descripcion"));
            prod.setPrecio(rs.getDouble("precio"));
            prod.setStock(rs.getDouble("stock"));
        }
    } catch (java.sql.SQLException e) {
        System.out.println("Error en ProductoDAO.buscarPorId: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (java.sql.SQLException e) {}
        try { if (ps != null) ps.close(); } catch (java.sql.SQLException e) {}
        try { if (con != null) con.close(); } catch (java.sql.SQLException e) {}
    }
    return prod;
}
// Método crítico de negocio: Resta la cantidad comprada del stock actual
public boolean restarStock(int idProducto, double cantidadComprada) {
    Connection con = null;
    PreparedStatement ps = null;
    boolean actualizado = false;

    try {
        con = Conexion.obtenerConexion();
        // Restamos directamente en SQL garantizando consistencia
        String sql = "UPDATE producto SET stock = stock - ? WHERE id_producto = ? AND stock >= ?";
        ps = con.prepareStatement(sql);
        ps.setDouble(1, cantidadComprada);
        ps.setInt(2, idProducto);
        ps.setDouble(3, cantidadComprada); // Evita que el stock quede en negativo

        if (ps.executeUpdate() > 0) {
            actualizado = true;
        }
    } catch (SQLException e) {
        System.out.println("Error en ProductoDAO.restarStock: " + e.getMessage());
    } finally {
        try { if (ps != null) ps.close(); } catch (SQLException e) {}
        try { if (con != null) con.close(); } catch (SQLException e) {}
    }
    return actualizado;
}
}
