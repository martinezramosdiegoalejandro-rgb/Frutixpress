<%-- 
    Document   : registro
    Created on : 20 jul 2026, 8:32:09 p.m.
    Author     : Diego Martinez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrarse - Frutixpress</title>
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
            .register-card {
                background-color: rgba(57, 54, 54, 0.95);
                border-radius: 10px;
                padding: 30px;
                color: #ffffff;
            }
            .input-field input:focus {
                border-bottom: 1px solid #689f38 !important;
                box-shadow: 0 1px 0 0 #689f38 !important;
            }
            .input-field label { color: #b0bec5; }
            .input-field input { color: #fff; }
        </style>
    </head>
    <body>
        <div class="container" style="margin-top: 30px;">
            <div class="row">
                <div class="col s12 m8 offset-m2">
                    <!-- Modificado: Añadido fondo #393636, padding interno y estilos para inputs en fondo oscuro -->
                    <div class="card register-card z-depth-5" style="background-color: #393636; padding: 35px 25px; border-radius: 12px; color: white;">
                        
                        <div class="center-align" style="margin-bottom: 30px;">
                            <i class="large material-icons light-green-text text-darken-1">person_add</i>
                            <h4 class="light-green-text text-darken-1" style="font-weight: bold; margin-top: 0;">Crear Cuenta</h4>
                            <p class="grey-text text-lighten-2">Regístrate para realizar tus compras en Frutixpress</p>
                        </div>
                        
                        <!-- Formulario apuntando al nuevo controlador de registro -->
                        <form action="RegistroController" method="POST" class="col s12">
                            
                            <!-- Estilos rápidos para forzar que Materialize sea legible sobre fondo gris -->
                            <style>
                                .register-card .input-field input { color: #ffffff !important; border-bottom: 1px solid #e0e0e0 !important; }
                                .register-card .input-field input:focus { border-bottom: 1px solid #7cb342 !important; box-shadow: 0 1px 0 0 #7cb342 !important; }
                                .register-card .input-field label { color: #b0bec5 !important; }
                                .register-card .input-field input:focus + label { color: #7cb342 !important; }
                                .register-card .input-field .prefix { color: #ffffff !important; }
                                .register-card .input-field .prefix.active { color: #7cb342 !important; }
                            </style>

                            <div class="row">
                                <div class="input-field col s12 m6">
                                    <i class="material-icons prefix">account_circle</i>
                                    <input id="reg_nombre" type="text" name="txtNombre" class="validate" required>
                                    <label for="reg_nombre">Nombre Completo</label>
                                </div>
                                <div class="input-field col s12 m6">
                                    <i class="material-icons prefix">email</i>
                                    <input id="reg_correo" type="email" name="txtCorreo" class="validate" required>
                                    <label for="reg_correo">Correo Electrónico</label>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="input-field col s12 m6">
                                    <i class="material-icons prefix">home</i>
                                    <input id="reg_dir" type="text" name="txtDireccion" class="validate" required>
                                    <label for="reg_dir">Dirección de Envío</label>
                                </div>
                                <div class="input-field col s12 m6">
                                    <i class="material-icons prefix">phone</i>
                                    <input id="reg_tel" type="text" name="txtTelefono" class="validate" required>
                                    <label for="reg_tel">Teléfono</label>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">lock</i>
                                    <input id="reg_password" type="password" name="txtPassword" class="validate" required>
                                    <label for="reg_password">Contraseña</label>
                                </div>
                            </div>

                            <div class="center-align" style="margin-top: 20px;">
                                <button class="btn waves-effect waves-light light-green darken-3 btn-large" style="width: 100%; margin-bottom: 20px; font-weight: bold;" type="submit">
                                    Registrarme <i class="material-icons right">assignment_turned_in</i>
                                </button>
                                <a href="principal.jsp" class="light-green-text text-lighten-4" style="text-decoration: underline;">¿Ya tienes cuenta? Inicia sesión</a>
                            </div>
                        </form>
                        <div class="clearfix"></div> <!-- Evita colapsos de floats de Materialize -->
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        
        <% 
            String errorReg = request.getParameter("errorRegistro");
            if ("true".equals(errorReg)) {
        %>
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    M.toast({html: 'Error al registrar. Inténtalo de nuevo o usa otro correo.', classes: 'rounded red darken-3', displayLength: 4000});
                });
            </script>
        <% } %>
    </body>
</html>
