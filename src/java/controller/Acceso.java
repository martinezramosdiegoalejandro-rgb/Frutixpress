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
import model.ClienteDAO;
import model.ClienteVO;

@WebServlet(name = "Acceso", urlPatterns = {"/Acceso"})
public class Acceso extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Recibir los parámetros del formulario HTML/JSP
        String txtUsuario = request.getParameter("usuario");
        String txtPass = request.getParameter("password");
        
        // 2. Instanciar la lógica de negocio (DAO)
        ClienteDAO dao = new ClienteDAO();
        ClienteVO cliente = dao.validarLogin(txtUsuario, txtPass);
        
        // 3. Evaluar el resultado de la consulta
        if (cliente != null) {
            // Éxito: Creamos una sesión de usuario y guardamos su objeto VO
            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuarioLogueado", cliente);
            
            // Redirigir a la vista de la tienda
            response.sendRedirect("vistas/tienda.jsp");
        } else {
            // Fallo: Enviamos un atributo de error y regresamos al login
            request.setAttribute("errorMsg", "Datos incorrectos. Intente de nuevo.");
            request.getRequestDispatcher("principal.jsp").forward(request, response);
        }
    }
}