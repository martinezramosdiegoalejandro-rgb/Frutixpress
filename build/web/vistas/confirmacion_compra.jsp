<%-- 
    Document   : confirmacion_compra
    Created on : 25 jun 2026, 6:51:06 p.m.
    Author     : Diego Martinez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Compra Exitosa - Frutixpress</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <style>
            body {
                background-color: #393636; /* Color negro principal de la marca */
                display: flex;
                min-height: 100vh;
                flex-direction: column;
                justify-content: center;
            }
            .success-card {
                background: white;
                padding: 40px;
                border-radius: 12px;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="row">
                <div class="col s12 m8 offset-m2 l6 offset-l3 center-align">
                    <div class="success-card z-depth-4">
                        
                        <div class="btn-floating btn-large pulse light-green darken-3" style="width: 80px; height: 80px; line-height: 80px; pointer-events: none;">
                            <i class="material-icons" style="font-size: 45px; line-height: 80px;">check_circle</i>
                        </div>
                        
                        <h4 class="grey-text text-darken-3" style="font-weight: bold; margin-top: 30px;">¡Operación Exitosa!</h4>
                        <p class="flow-text light-green-text text-darken-4" style="font-size: 18px;">
                            ¡Tu pedido se ha registrado satisfactoriamente!
                        </p>
                        <p class="grey-text">Nuestros repartidores se encargarán de llevar la frescura del campo a tu hogar.</p>
                        
                        <br><br>
                        
                        <a href="tienda.jsp" class="btn waves-effect waves-light #393636 grey darken-3 btn-large style="width: 100%; border-radius: 6px;">
                            Volver a la Tienda <i class="material-icons right">store</i>
                        </a>
                        
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>
