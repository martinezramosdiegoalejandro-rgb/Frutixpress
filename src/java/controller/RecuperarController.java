/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ClienteDAO;

@WebServlet(name = "RecuperarController", urlPatterns = {"/RecuperarController"})
public class RecuperarController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Capturamos los parámetros del formulario recuperar.jsp
        String correo = request.getParameter("txtCorreo");
        String passwordNueva = request.getParameter("txtPasswordNueva");
        
        // 2. Invocamos al modelo para realizar la actualización
        ClienteDAO dao = new ClienteDAO();
        boolean exito = dao.actualizarContraseña(correo, passwordNueva);
        
        if (exito) {
            // Redireccionamos a la principal con una bandera de éxito
            response.sendRedirect("principal.jsp?cambioExitoso=true");
        } else {
            // Si el correo no existía o falló el update, regresa con error
            response.sendRedirect("recuperar.jsp?errorRecuperar=true");
        }
    }
}