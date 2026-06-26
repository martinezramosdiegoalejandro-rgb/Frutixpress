<%-- 
    Document   : tienda
    Created on : 24 jun 2026, 7:03:48 p.m.
    Author     : Diego Martinez
--%>

<%@page import="model.ProductoVO"%>
<%@page import="java.util.List"%>
<%@page import="model.ProductoDAO"%>
<%@page import="model.ClienteVO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Validamos que el usuario realmente haya iniciado sesión
    ClienteVO cliente = (ClienteVO) session.getAttribute("usuarioLogueado");
    if (cliente == null) {
        // Si intenta entrar directo sin loguearse, lo mandamos al index
        response.sendRedirect("../principal.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tienda Virtual - Frutixpress</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <style>
            body { background-color: #f5f5f5; }
            nav { background-color: #393636 !important; } /* Tono negro principal */
            .card-producto { border-radius: 8px; overflow: hidden; }
        </style>
    </head>
    <body>
        
        <nav class="z-depth-1">
            <div class="nav-wrapper container">
                <a href="#" class="brand-logo light-green-text text-darken-1" style="font-weight: 500;">Frutixpress</a>
                <ul id="nav-mobile" class="right hide-on-med-and-down">
                    <li><a href="#"><i class="material-icons left">shopping_cart</i>Carrito</a></li>
                    <li><a class="waves-effect waves-light btn red darken-2" href="../principal.jsp?logout=true">Salir</a></li>
                </ul>
            </div>
        </nav>

        <div class="container" style="margin-top: 30px;">
            <div class="row">
                <div class="col s12">
                    <div class="card-panel light-green darken-3 white-text">
                        <h5>¡Bienvenido/a de nuevo, <b><%= cliente.getNombre() %></b>! 👋</h5>
                        <p style="margin-bottom: 0;">Disfruta de las frutas más frescas recolectadas directamente del campo colombiano hasta tu hogar.</p>
                    </div>
                </div>
            </div>

            <h4 class="grey-text text-darken-3" style="font-weight: 300; margin-bottom: 25px;">Catálogo de Frutas Disponibles</h4>
            
            <div class="row" style="display: flex; flex-wrap: wrap;">
                <%
                    ProductoDAO prodDAO = new ProductoDAO();
                    List<ProductoVO> productos = prodDAO.listarProductos();
                    
                    if(productos.isEmpty()){
                %>
                    <div class="col s12 center-align">
                        <p class="flow-text grey-text">No hay productos disponibles en este momento.</p>
                    </div>
                <%
                    } else {
                        for(ProductoVO prod : productos) {
                %>
                    <div class="col s12 m6 l4">
                        <div class="card card-producto hoverable">
                            <div class="card-content">
                                <span class="card-title black-text style="font-weight: bold;"><%= prod.getNombre() %></span>
                                <p class="grey-text text-darken-1" style="min-height: 50px;"><%= prod.getDescripcion() %></p>
                                <br>
                                <div class="row" style="margin-bottom: 0;">
                                    <div class="col s6">
                                        <h5 class="light-green-text text-darken-3" style="margin: 0; font-weight: bold;">$<%= String.format("%,.2f", prod.getPrecio()) %></h5>
                                        <small class="grey-text">Stock: <%= prod.getStock() %> kg</small>
                                    </div>
                                    <div class="col s6 right-align">
                                        <form action="../TiendaController" method="POST">
    <input type="hidden" name="idProducto" value="<%= prod.getIdProducto() %>">
    <button type="submit" class="btn-floating btn-large waves-effect waves-light light-green darken-3">
        <i class="material-icons">add_shopping_cart</i>
    </button>
</form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <% 
                        }
                    }
                %>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <% 
        String alerta = (String) request.getAttribute("alertaAgotado");
        if (alerta != null) {
    %>
        <script>
            // Este es un componente nativo de Materialize CSS para lanzar notificaciones
            M.toast({html: '<%= alerta %>', classes: 'rounded red darken-3', displayLength: 4000});
        </script>
    <% } %>

</body> ```

---

### ¿Cómo verificar que quedó perfecto?
El final de tu archivo `tienda.jsp` debería verse estructurado de la siguiente manera:

```jsp
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

  <% 
        String mensajeAgotado = (String) request.getAttribute("alertaAgotado");
        String errorTransaccion = request.getParameter("errorTransaccion");
        String productoAgotado = request.getParameter("productoAgotado");
        
        if (mensajeAgotado != null) {
            // Código existente para alertas internas
        } else if ("true".equals(productoAgotado)) {
    %>
        <script>
            M.toast({html: 'Lo sentimos, este producto se encuentra temporalmente agotado.', classes: 'rounded red darken-3', displayLength: 4000});
        </script>
    <%
        } else if ("true".equals(errorTransaccion)) {
    %>
        <script>
            M.toast({html: 'Error crítico al procesar la transacción de compra. Verifica restricciones en la BD.', classes: 'rounded red darken-3', displayLength: 5000});
        </script>
    <% } %>
</body>
</html>