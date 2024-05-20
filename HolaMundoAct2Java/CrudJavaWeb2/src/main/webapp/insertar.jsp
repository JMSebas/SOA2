

    <%@page import="Quinto.Validators"%>
    <%@page import="java.net.http.HttpResponse"%>
    <%@page import="Quinto.ApiConsumer"%>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>  
        <jsp:include page = "head.jsp"/>
        <body>
            <div>
                <jsp:include page= "navbar.jsp"/>
            </div>
            <form method="POST" class="p-3">
                <div class="form-group">
                    <label for="cedula">Cedula</label>
                    <input type="text" class="form-control" id="cedula" name="cedula" required="">
                </div>
                <div class="form-group">
                    <label for="nombre">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" required="">
                </div>
                <div class="form-group">
                    <label for="Apellido">Apellido</label>
                    <input type="text" class="form-control" id="apellido" name="apellido" required="">
                </div>
                <div class="form-group">
                    <label for="Direccion">Direccion</label>
                    <input type="text" class="form-control" id="direccion" name="direccion" required="">
                </div>
                <div class="form-group">
                    <label for="telefono">Telefono</label>
                    <input type="text" class="form-control" id="telefono" name="telefono" required="">
                </div>

                <button type="submit" class="btn btn-primary my-3">Crear</button>
            </form>

                <%
                    Validators v = new Validators();
                    if (request.getMethod().equals("POST")) {
                         if (v.IdValidator(request.getParameter("cedula")) == true ) {
                        ApiConsumer api = new ApiConsumer();
                        HttpResponse<String> responses = api.postStudent(
                        request.getParameter("cedula"), 
                        request.getParameter("nombre"), 
                        request.getParameter("apellido"), 
                        request.getParameter("direccion"), 
                        request.getParameter("telefono")
                        );

                        if (api.getResponseStatus(responses) == 200) {
                                response.sendRedirect("index.jsp");
                        } else {
                            out.print("<div>No se pudo crear el estudiante</div>");
                        }

                    }
                    else {
        %>
                    <script>
                        window.alert("¡La cédula ingresada no es válida!");
                    </script>
        <%
                }
            }
        %>
    </body>
</html>