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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.ClienteVO;
import model.DetalleCarritoDAO;
import model.DetalleCarritoVO;
import model.ItemCarrito;
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

        String accion = request.getParameter("accion"); // Captura si es "comprar", "carrito", "eliminar" o "pagar"

        // =========================================================================
        // NUEVO FLUJO D: PROCESAR EL PAGO DEL CARRITO COMPLETO
        // =========================================================================
        if ("pagar".equals(accion)) {
            List<ItemCarrito> carrito = (List<ItemCarrito>) sesion.getAttribute("carrito");
            
            if (carrito != null && !carrito.isEmpty()) {
                ProductoDAO prodDAO = new ProductoDAO();
                
                // 1. Recorremos los productos del carrito para restar el stock en la BD
                for (ItemCarrito item : carrito) {
                    int idProd = item.getProducto().getIdProducto();
                    double cantComprada = item.getCantidad();
                    
                    // Descontamos el stock usando tu método existente
                    prodDAO.restarStock(idProd, cantComprada);
                }
                
                // 2. Limpiamos por completo el carrito de la sesión
                sesion.removeAttribute("carrito");
                
                // 3. Redirigimos al JSP de éxito
                response.sendRedirect("vistas/confirmacion_compra.jsp");
            } else {
                // Si intenta pagar con el carrito vacío, lo devolvemos a la tienda
                response.sendRedirect("vistas/tienda.jsp");
            }
            return; // Corta la ejecución para evitar leer parámetros nulos abajo
        }

        // =========================================================================
        // FLUJO C: ELIMINAR PRODUCTO DEL CARRITO
        // =========================================================================
        int idProducto = 0;
        if (request.getParameter("idProducto") != null) {
            idProducto = Integer.parseInt(request.getParameter("idProducto"));
        }

        if ("eliminar".equals(accion)) {
            List<ItemCarrito> carrito = (List<ItemCarrito>) sesion.getAttribute("carrito");
            
            if (carrito != null) {
                for (int i = 0; i < carrito.size(); i++) {
                    if (carrito.get(i).getProducto().getIdProducto() == idProducto) {
                        carrito.remove(i);
                        break; 
                    }
                }
                sesion.setAttribute("carrito", carrito);
            }
            response.sendRedirect("carrito.jsp");
            return; 
        }

        // =========================================================================
        // PARA LOS DEMÁS FLUJOS (Añadir/Comprar): Aquí SÍ se lee la cantidad
        // =========================================================================
        double cantidad = Double.parseDouble(request.getParameter("cantidad"));

        ProductoDAO prodDAO = new ProductoDAO();
        ProductoVO prod = prodDAO.buscarPorId(idProducto);

        if (prod != null) {
            double precioUnitario = prod.getPrecio();

            // =========================================================================
            // FLUJO A: AÑADIR AL CARRITO 
            // =========================================================================
            if ("carrito".equals(accion)) {
                List<ItemCarrito> carrito = (List<ItemCarrito>) sesion.getAttribute("carrito");
                if (carrito == null) {
                    carrito = new ArrayList<>();
                }
                
                boolean existe = false;
                for (ItemCarrito item : carrito) {
                    if (item.getProducto().getIdProducto() == idProducto) {
                        item.setCantidad(item.getCantidad() + cantidad);
                        existe = true;
                        break;
                    }
                }
                
                if (!existe) {
                    carrito.add(new ItemCarrito(prod, cantidad));
                }
                
                sesion.setAttribute("carrito", carrito);
                response.sendRedirect("carrito.jsp");
                return;
            }

            // =========================================================================
            // FLUJO B: COMPRA DIRECTA
            // =========================================================================
            double precioTotal = precioUnitario * cantidad;

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String fechaActual = sdf.format(new Date());

            int idCarritoSimulado = 1; 

            PedidoVO pedido = new PedidoVO();
            pedido.setFechaPedido(fechaActual);
            pedido.setEstadoPedido("Pendiente");
            pedido.setPrecioTotal(precioTotal);
            pedido.setIdCarrito(idCarritoSimulado);
            pedido.setIdRepartidor(null);

            PedidoDAO pedDAO = new PedidoDAO();
            boolean pedidoOk = pedDAO.registrarPedido(pedido);

            if (pedidoOk) {
                DetalleCarritoVO detalle = new DetalleCarritoVO();
                detalle.setIdProducto(idProducto);
                detalle.setIdCarrito(idCarritoSimulado);
                detalle.setCantidad(cantidad);
                detalle.setPrecioUnitario(precioUnitario);

                DetalleCarritoDAO detDAO = new DetalleCarritoDAO();
                boolean detalleOk = detDAO.agregarProductoAlCarrito(detalle);

                if (detalleOk) {
                    boolean stockOk = prodDAO.restarStock(idProducto, cantidad);
                    
                    if (stockOk) {
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