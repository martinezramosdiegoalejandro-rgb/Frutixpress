<%-- 
    Document   : recuperar
    Created on : 20 jul 2026, 8:54:01 p.m.
    Author     : Diego Martinez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Recuperar Contraseña - Frutixpress</title>
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
            /* Modificado: Color sólido idéntico al registro, bordes y padding uniforme */
            .recovery-card {
                background-color: #393636 !important;
                border-radius: 12px !important;
                padding: 35px 25px !important;
                color: #ffffff;
            }
            .input-field input { 
                color: #ffffff !important; 
                border-bottom: 1px solid #e0e0e0 !important; 
            }
            .input-field input:focus {
                border-bottom: 1px solid #7cb342 !important;
                box-shadow: 0 1px 0 0 #7cb342 !important;
            }
            .input-field label { 
                color: #b0bec5 !important; 
            }
            .input-field input:focus + label { 
                color: #7cb342 !important; 
            }
            /* Nuevos: Corrección para que los iconos de Materialize se adapten al fondo oscuro */
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
                    <div class="card recovery-card z-depth-5">
                        <div class="center-align" style="margin-bottom: 30px;">
                            <i class="large material-icons light-green-text text-darken-1">lock_open</i>
                            <h4 class="light-green-text text-darken-1" style="font-weight: bold; margin-top: 0;">Restablecer</h4>
                            <p class="grey-text text-lighten-2">Ingresa tu correo y tu nueva contraseña</p>
                        </div>
                        
                        <!-- Formulario apuntando al nuevo controlador de registro -->
                        <form action="RecuperarController" method="POST" class="col s12">
                            <div class="row">
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">email</i>
                                    <input id="rec_correo" type="email" name="txtCorreo" class="validate" required>
                                    <label for="rec_correo">Correo Electrónico</label>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">lock</i>
                                    <input id="rec_password" type="password" name="txtPasswordNueva" class="validate" required>
                                    <label for="rec_password">Nueva Contraseña</label>
                                </div>
                            </div>

                            <div class="center-align" style="margin-top: 20px;">
                                <button class="btn waves-effect waves-light light-green darken-3 btn-large" style="width: 100%; margin-bottom: 20px; font-weight: bold;" type="submit">
                                    Actualizar Contraseña <i class="material-icons right">update</i>
                                </button>
                                <a href="principal.jsp" class="light-green-text text-lighten-4" style="text-decoration: underline;">Regresar al Inicio de Sesión</a>
                            </div>
                        </form>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        
        <% 
            String errorRec = request.getParameter("errorRecuperar");
            if ("true".equals(errorRec)) {
        %>
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    M.toast({html: 'El correo ingresado no está registrado.', classes: 'rounded red darken-3', displayLength: 4000});
                });
            </script>
        <% } %>
    </body>
</html>