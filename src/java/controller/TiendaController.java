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
import java.io.IOException;
import model.ProductoDAO;
import model.ProductoVO;

@WebServlet(name = "TiendaController", urlPatterns = {"/TiendaController"})
public class TiendaController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Recibir el ID del producto enviado de forma oculta desde la tienda
        String idParam = request.getParameter("idProducto");
        
        if (idParam != null) {
            int idProducto = Integer.parseInt(idParam);
            
            // 2. Consultar los detalles en la base de datos
            ProductoDAO dao = new ProductoDAO();
            ProductoVO producto = dao.buscarPorId(idProducto);
            
            if (producto != null) {
                // 3. Verificar la disponibilidad (Stock > 0)
                if (producto.getStock() > 0) {
                    // SI HAY STOCK: Guardamos el objeto en el request y vamos al detalle
                    request.setAttribute("productoSeleccionado", producto);
                    request.getRequestDispatcher("vistas/detalle_producto.jsp").forward(request, response);
                } else {
                    // NO HAY STOCK: Redirección limpia pasando un parámetro en la URL
                    response.sendRedirect("vistas/tienda.jsp?productoAgotado=true");
                }
            } else {
                response.sendRedirect("vistas/tienda.jsp");
            }
        } else {
            response.sendRedirect("vistas/tienda.jsp");
        }
    }
}