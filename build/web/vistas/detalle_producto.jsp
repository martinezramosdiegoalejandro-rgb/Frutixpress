<%-- 
    Document   : detalle_producto
    Created on : 25 jun 2026, 5:24:39 p.m.
    Author     : Diego Martinez
--%>

<%@page import="model.ProductoVO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Recuperamos el producto enviado desde el controlador
    ProductoVO prod = (ProductoVO) request.getAttribute("productoSeleccionado");
    if (prod == null) {
        // Protección: Si intentan entrar directo a la URL, los regresamos a la tienda
        response.sendRedirect("tienda.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sistema de venta de frutas virtual - Frutixpress</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <style>
            body { background-color: #f5f5f5; }
            nav { background-color: #393636 !important; }
            .detalle-card { background: white; padding: 30px; border-radius: 8px; margin-top: 20px; }
            .input-field input[type=number]:focus {
                border-bottom: 1px solid #689f38 !important;
                box-shadow: 0 1px 0 0 #689f38 !important;
            }
        </style>
    </head>
    <body>

        <nav class="z-depth-1">
            <div class="nav-wrapper container">
                <a href="#" class="brand-logo light-green-text text-darken-1" style="font-weight: 500;">Frutixpress</a>
            </div>
        </nav>

        <div class="container">
            <div class="row">
                <div class="col s12 m10 offset-m1 l8 offset-l2">
                    <div class="detalle-card z-depth-2">
                        
                        <span class="grey-text text-darken-1" style="font-size: 14px; text-transform: uppercase;">Detalle del Producto</span>
                        <h3 class="light-green-text text-darken-3" style="margin-top: 0; font-weight: bold;"><%= prod.getNombre() %></h3>
                        
                        <div class="row" style="margin-top: 30px;">
                            <div class="col s12 m5 center-align">
                               <div class="valign-wrapper grey lighten-3" style="height: 200px; width: 100%; border-radius: 8px; justify-content: center;">
    <i class="large material-icons grey-text text-lighten-1" style="font-size: 80px;">eco</i>
</div>
                            </div>
                            
                            <div class="col s12 m7">
                                <h5><b>Precio Unitario:</b> <span class="light-green-text text-darken-2">$<%= String.format("%,.2f", prod.getPrecio()) %> COP</span></h5>
                                <p class="grey-text text-darken-3" style="font-size: 16px;"><%= prod.getDescripcion() %></p>
                                <div class="chip light-green lighten-4 green-text text-darken-4">
                                    Stock disponible: <%= prod.getStock() %> kg
                                </div>
                                
                                <hr style="border: 0; border-top: 1px solid #e0e0e0; margin: 20px 0;">
                                
                                <form action="/Frutixpress/ProcesarPedido" method="POST">
                                    <input type="hidden" name="idProducto" value="<%= prod.getIdProducto() %>">
                                    
                                    <div class="input-field">
                                        <i class="material-icons prefix">fitness_center</i> 
                                        <input id="cantidad" name="cantidad" type="number" step="1.00" min="1.00" max="<%= prod.getStock() %>" class="validate" required>
                                        <label for="cantidad">Cantidad (kg)</label>
                                    </div>
                                    
                                    <div class="row" style="margin-top: 30px;">
                                        <!-- Botón 1: Añadir al Carrito -->
                                        <div class="col s12 m6" style="margin-bottom: 10px;">
                                            <button type="submit" name="accion" value="carrito" class="btn waves-effect waves-light orange darken-3 btn-large" style="width: 100%;">
                                                Añadir <i class="material-icons right">add_shopping_cart</i>
                                            </button>
                                        </div>
                                        
                                        <!-- Botón 2: Comprar Directamente -->
                                        <div class="col s12 m6" style="margin-bottom: 10px;">
                                            <button type="submit" name="accion" value="comprar" class="btn waves-effect waves-light light-green darken-3 btn-large" style="width: 100%;">
                                                Comprar Ya <i class="material-icons right">credit_card</i>
                                            </button>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col s12 center-align">
                                            <a href="vistas/tienda.jsp" class="waves-effect waves-red btn-flat red-text" style="width: 100%;">
                                                Cancelar y Volver
                                            </a>
                                        </div>
                                    </div>
                                </form>
                                
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>