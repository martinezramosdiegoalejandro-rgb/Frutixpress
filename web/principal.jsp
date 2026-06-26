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
            .login-card {
                background-color: rgba(57, 54, 54, 0.95); /* Tonalidad #393636 sugerida */
                border-radius: 10px;
                padding: 30px;
                color: #ffffff;
            }
            .input-field input[type=email]:focus, .input-field input[type=password]:focus {
                border-bottom: 1px solid #689f38 !important; /* light-green darken-3 */
                box-shadow: 0 1px 0 0 #689f38 !important;
            }
            .input-field label { color: #b0bec5; }
            .input-field input { color: #fff; }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col s12 m6 offset-m3">
                    <div class="card login-card z-depth-5">
                        <div class="center-align">
                            <i class="large material-icons light-green-text text-darken-1">local_grocery_store</i>
                            <h4 class="light-green-text text-darken-1" style="font-weight: bold; margin-top: 0;">Frutixpress</h4>
                            <p class="grey-text text-lighten-1">Sistema Virtual de Venta de Frutas</p>
                        </div>
                        
                        <% 
                            String msg = (String) request.getAttribute("errorMsg");
                            if (msg != null) {
                        %>
                            <div class="card-panel red darken-2 white-text center-align" style="padding: 10px; border-radius: 5px;">
                                <%= msg %>
                            </div>
                        <% } %>

                        <form action="Acceso" method="POST">
                            <div class="input-field">
                                <i class="material-icons prefix">email</i>
                                <input id="usuario" name="usuario" type="email" class="validate" required>
                                <label for="usuario">Correo Electrónico</label>
                            </div>
                            <div class="input-field">
                                <i class="material-icons prefix">lock</i>
                                <input id="password" name="password" type="password" class="validate" required>
                                <label for="password">Contraseña</label>
                            </div>
                            <br>
                            <div class="center-align">
                                <button class="btn waves-effect waves-light light-green darken-3 btn-large style="width: 100%;" type="submit">
                                    Ingresar <i class="material-icons right">send</i>
                                </button>
                            </div>
                        </form>
                        
                        <div class="row" style="margin-top: 25px; margin-bottom: 0;">
                            <div class="col s6 left-align">
                                <a href="#" class="light-green-text text-lighten-2 text-small">Registrarse</a>
                            </div>
                            <div class="col s6 right-align">
                                <a href="#" class="grey-text text-lighten-1 text-small">¿Olvidó contraseña?</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>
