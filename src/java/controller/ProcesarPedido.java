/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.ClienteVO;
import model.DetalleCarritoDAO;
import model.DetalleCarritoVO;
import model.PedidoDAO;
import model.PedidoVO;
import model.ProductoDAO;
import model.ProductoVO;

@WebServlet(name = "ProcesarPedido", urlPatterns = {"/ProcesarPedido"})
public class ProcesarPedido extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession sesion = request.getSession();
        ClienteVO cliente = (ClienteVO) sesion.getAttribute("usuarioLogueado");
        
        if (cliente == null) {
            response.sendRedirect("principal.jsp");
            return;
        }

        // 1. Recibir parámetros del formulario de detalles
        int idProducto = Integer.parseInt(request.getParameter("idProducto"));
        double cantidad = Double.parseDouble(request.getParameter("cantidad"));

        // Consultar el producto para obtener el precio unitario exacto
        ProductoDAO prodDAO = new ProductoDAO();
        ProductoVO prod = prodDAO.buscarPorId(idProducto);

        if (prod != null) {
            double precioUnitario = prod.getPrecio();
            double precioTotal = precioUnitario * cantidad;

            // Formatear la fecha actual al estándar requerido por la BD ('2026-06-25 18:00:00')
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String fechaActual = sdf.format(new Date());

            // 2. Transacción - Registrar Pedido (Usamos id_carrito = 1 de manera fija para las pruebas controladas)
            int idCarritoSimulado = 1; 

            PedidoVO pedido = new PedidoVO();
            pedido.setFechaPedido(fechaActual);
            pedido.setEstadoPedido("Pendiente");
            pedido.setPrecioTotal(precioTotal);
            pedido.setIdCarrito(idCarritoSimulado);
            pedido.setIdRepartidor(null); // Pendiente por asignar asignación automática

            PedidoDAO pedDAO = new PedidoDAO();
            boolean pedidoOk = pedDAO.registrarPedido(pedido);

            if (pedidoOk) {
                // 3. Registrar el Detalle de la compra en la tabla intermedia
                DetalleCarritoVO detalle = new DetalleCarritoVO();
                detalle.setIdProducto(idProducto);
                detalle.setIdCarrito(idCarritoSimulado);
                detalle.setCantidad(cantidad);
                detalle.setPrecioUnitario(precioUnitario);

                DetalleCarritoDAO detDAO = new DetalleCarritoDAO();
                boolean detalleOk = detDAO.agregarProductoAlCarrito(detalle);

                if (detalleOk) {
                    // 4. Actualizar / Restar el Stock del inventario
                    boolean stockOk = prodDAO.restarStock(idProducto, cantidad);
                    
                    if (stockOk) {
                        // ¡Éxito absoluto en toda la operación! Redirigimos a la pantalla de éxito
                        response.sendRedirect("vistas/confirmacion_compra.jsp");
                        return;
                    }
                }
            }
            
           response.sendRedirect("vistas/tienda.jsp?errorTransaccion=true");
        } else {
            response.sendRedirect("vistas/tienda.jsp");
        }
    }
}
