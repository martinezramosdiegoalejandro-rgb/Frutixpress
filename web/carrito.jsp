<%-- 
    Document   : carrito
    Created on : 20 jul 2026, 9:18:45 p.m.
    Author     : Diego Martinez
--%>

<%@page import="model.ItemCarrito"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mi Carrito - Frutixpress</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <style>
            body { background-color: #f5f5f5; }
            nav { background-color: #393636 !important; }
            .carrito-container { background: white; padding: 25px; border-radius: 8px; margin-top: 30px; }
        </style>
    </head>
    <body>
        <nav class="z-depth-1">
            <div class="nav-wrapper container">
                <a href="vistas/tienda.jsp" class="brand-logo light-green-text text-darken-1">Frutixpress</a>
            </div>
        </nav>

        <div class="container">
            <div class="card carrito-container z-depth-2">
                <h4 class="light-green-text text-darken-3" style="font-weight: bold;">Tu Carrito de Compras</h4>
                
                <%
                    List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
                    if (carrito == null || carrito.isEmpty()) {
                %>
                    <div class="center-align" style="padding: 40px 0;">
                        <i class="large material-icons grey-text">remove_shopping_cart</i>
                        <h5>Tu carrito está vacío</h5>
                        <a href="vistas/tienda.jsp" class="btn light-green darken-2" style="margin-top: 15px;">Volver a la tienda</a>
                    </div>
                <%
                    } else {
                        double totalGeneral = 0;
                %>
                    <table class="striped responsive-table">
                        <thead>
                            <tr>
                                <th>Producto</th>
                                <th>Precio Unitario</th>
                                <th>Cantidad</th>
                                <th>Subtotal</th>
                                <th class="center-align">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (ItemCarrito item : carrito) {
                                    totalGeneral += item.getSubtotal();
                            %>
                            <tr>
                                <td><b><%= item.getProducto().getNombre() %></b></td>
                                <td>$<%= String.format("%,.2f", item.getProducto().getPrecio()) %> COP</td>
                                <td><%= item.getCantidad() %> kg</td>
                                <td><b>$<%= String.format("%,.2f", item.getSubtotal()) %> COP</b></td>
                                
                                <td class="center-align">
                                    <form action="ProcesarPedido" method="POST" style="margin:0;">
                                        <input type="hidden" name="idProducto" value="<%= item.getProducto().getIdProducto() %>">
                                        <button type="submit" name="accion" value="eliminar" class="btn-flat waves-effect waves-red red-text" title="Eliminar del carrito">
                                            <i class="material-icons">delete</i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                            <tr class="light-green lighten-5">
                                <td colspan="2"></td>
                                <td><h5><b>Total:</b></h5></td>
                                <td><h5><b class="light-green-text text-darken-4">$<%= String.format("%,.2f", totalGeneral) %> COP</b></h5></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                    
                    <div class="row" style="margin-top: 30px;">
                        <div class="col s12 m6">
                            <a href="vistas/tienda.jsp" class="btn-flat waves-effect waves-light grey-text text-darken-2" style="width: 100%; text-align: center;">
                                <i class="material-icons left">arrow_back</i> Seguir Comprando
                            </a>
                        </div>
                        <!-- MODIFICADO: Ahora es un formulario que procesa la compra en el servidor -->
                        <div class="col s12 m6">
                            <form action="ProcesarPedido" method="POST" style="margin:0;">
                                <button type="submit" name="accion" value="pagar" class="btn btn-large light-green darken-3 waves-effect waves-light" style="width: 100%;">
                                    Proceder al Pago <i class="material-icons right">payment</i>
                                </button>
                            </form>
                        </div>
                    </div>
                <%
                    }
                %>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>