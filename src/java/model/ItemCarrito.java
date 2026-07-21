/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class ItemCarrito {
    private ProductoVO producto;
    private double cantidad;

    public ItemCarrito() {
    }

    public ItemCarrito(ProductoVO producto, double cantidad) {
        this.producto = producto;
        this.cantidad = cantidad;
    }

    public ProductoVO getProducto() { return producto; }
    public void setProducto(ProductoVO producto) { this.producto = producto; }

    public double getCantidad() { return cantidad; }
    public void setCantidad(double cantidad) { this.cantidad = cantidad; }
    
    // Método de utilidad para calcular el subtotal del ítem
    public double getSubtotal() {
        return this.producto.getPrecio() * this.cantidad;
    }
}