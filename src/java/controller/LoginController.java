/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller; // CORREGIDO: En singular como tu proyecto

import java.io.IOException;
// CORREGIDO: Cambiados de 'javax' a 'jakarta' para que Tomcat 11 los reconozca
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ClienteDAO; // CORREGIDO: En singular
import model.ClienteVO;  // CORREGIDO: En singular

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String correo = request.getParameter("txtCorreo");
        String password = request.getParameter("txtPassword");
        
        ClienteDAO clienteDao = new ClienteDAO();
        ClienteVO clienteLogueado = clienteDao.validarLogin(correo, password);
        
        if (clienteLogueado != null) {
            // Credenciales correctas: Creamos la sesión del usuario
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", clienteLogueado);
            
            // Lo mandamos directo al catálogo de la tienda
            response.sendRedirect("vistas/tienda.jsp");
        } else {
            // Credenciales incorrectas: regresamos a la principal con una alerta de error
            response.sendRedirect("principal.jsp?errorLogin=true");
        }
    }
}