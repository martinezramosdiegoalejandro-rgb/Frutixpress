<%-- 
    Document   : principal
    Created on : 24 jun 2026, 6:48:38 p.m.
    Author     : Diego Martinez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sistema de venta de frutas virtual - Frutixpress</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <style>
            body {
                background: linear-gradient(rgba(0, 0, 0, 0.65), rgba(0, 0, 0, 0.75)), 
                            url('https://images.unsplash.com/photo-1610832958506-aa56368176cf?q=80&w=1470&auto=format&fit=crop') no-repeat center center fixed;
                background-size: cover;
                display: flex;
                min-height: 100vh;
                flex-direction: column;
                justify-content: center;
            }
            /* Modificado: Color sólido sin transparencias, bordes y padding uniforme */
            .login-card {
                background-color: #393636 !important;
                border-radius: 12px !important;
                padding: 35px 25px !important;
                color: #ffffff;
            }
            .input-field input[type=email]:focus, .input-field input[type=password]:focus {
                border-bottom: 1px solid #7cb342 !important;
                box-shadow: 0 1px 0 0 #7cb342 !important;
            }
            .input-field label { 
                color: #b0bec5 !important; 
            }
            .input-field input { 
                color: #fff !important; 
                border-bottom: 1px solid #e0e0e0 !important;
            }
            /* Añadido: Ajuste para los iconos laterales del formulario */
            .input-field .prefix { 
                color: #ffffff !important; 
            }
            .input-field .prefix.active { 
                color: #7cb342 !important; 
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col s12 m6 offset-m3">
                    <div class="card login-card z-depth-5">
                        <div class="center-align" style="margin-bottom: 30px;">
                            <i class="large material-icons light-green-text text-darken-1">local_grocery_store</i>
                            <h4 class="light-green-text text-darken-1" style="font-weight: bold; margin-top: 0;">Frutixpress</h4>
                            <p class="grey-text text-lighten-2">Sistema Virtual de Venta de Frutas</p>
                        </div>
                        
                        <form action="LoginController" method="POST" class="col s12">
                            <div class="row">
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">email</i>
                                    <input id="login_correo" type="email" name="txtCorreo" class="validate" required>
                                    <label for="login_correo">Correo Electrónico</label>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">lock</i>
                                    <input id="login_password" type="password" name="txtPassword" class="validate" required>
                                    <label for="login_password">Contraseña</label>
                                </div>
                            </div>

                            <!-- Modificado: Separación e ingreso con ancho reducido al 60% -->
                            <div class="center-align" style="margin-top: 30px; margin-bottom: 25px;">
                                <button class="btn waves-effect waves-light light-green darken-3 btn-large" style="width: 60%; font-weight: bold;" type="submit">
                                    Ingresar <i class="material-icons right">send</i>
                                </button>
                            </div>
                        </form>
                        
                        <!-- Modificado: Mayor separación desde la base del formulario -->
                        <div class="row" style="margin-top: 35px; margin-bottom: 10px;">
                            <div class="col s6 left-align">
                                <a href="registro.jsp" class="light-green-text text-lighten-3 text-small" style="text-decoration: underline;">Registrarse</a>
                            </div>
                            <div class="col s6 right-align">
                                <a href="recuperar.jsp" class="grey-text text-lighten-2 text-small" style="text-decoration: underline;">¿Olvidó su contraseña?</a>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 1. Cargamos PRIMERO la librería JavaScript de Materialize -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

        <!-- 2. Cargamos DESPUÉS los scripts controladores de notificaciones -->
        <% 
            String errorLogin = request.getParameter("errorLogin");
            if ("true".equals(errorLogin)) {
        %>
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    M.toast({html: 'El correo o contraseña son incorrectos. Verifica tus datos.', classes: 'rounded red darken-3', displayLength: 4000});
                });
            </script>
        <% } %>
        <% 
            String registroExitoso = request.getParameter("registroExitoso");
            if ("true".equals(registroExitoso)) {
        %>
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    M.toast({html: '¡Cuenta creada con éxito! Ya puedes iniciar sesión.', classes: 'rounded green darken-3', displayLength: 5000});
                });
            </script>
        <% } %>
        <% 
            String cambioExitoso = request.getParameter("cambioExitoso");
            if ("true".equals(cambioExitoso)) {
        %>
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    M.toast({html: '¡Contraseña actualizada con éxito! Ya puedes ingresar.', classes: 'rounded blue darken-3', displayLength: 5000});
                });
            </script>
        <% } %>
    </body>
</html>
