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
import model.ClienteVO;

@WebServlet(name = "RegistroController", urlPatterns = {"/RegistroController"})
public class RegistroController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Capturar parámetros del formulario
        String nombre = request.getParameter("txtNombre");
        String correo = request.getParameter("txtCorreo");
        String password = request.getParameter("txtPassword");
        String direccion = request.getParameter("txtDireccion");
        String telefono = request.getParameter("txtTelefono");
        
        // 2. Llenar el objeto de transferencia de datos (VO)
        ClienteVO nuevoCliente = new ClienteVO();
        nuevoCliente.setNombre(nombre);
        nuevoCliente.setCorreo(correo);
        nuevoCliente.setContraseña(password);
        nuevoCliente.setDireccion(direccion);
        nuevoCliente.setTelefono(telefono);
        
        // 3. Insertar mediante el DAO
        ClienteDAO dao = new ClienteDAO();
        boolean insertado = dao.registrarCliente(nuevoCliente);
        
        if (insertado) {
            // Si se registra con éxito, vuelve al Login pasándole un aviso exitoso
            response.sendRedirect("principal.jsp?registroExitoso=true");
        } else {
            // Si falla, regresa a la página de registro
            response.sendRedirect("registro.jsp?errorRegistro=true");
        }
    }
}