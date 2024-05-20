<%@page import="java.net.http.HttpResponse"%>
<%@page import="Quinto.ApiConsumer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Estudiante</title>
    <jsp:include page="head.jsp" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<%
    if (request.getMethod().equals("POST")) {
        ApiConsumer api = new ApiConsumer();
        HttpResponse<String> responses = api.update(
                request.getParameter("cedula"),
                request.getParameter("nombre"),
                request.getParameter("apellido"),
                request.getParameter("direccion"),
                request.getParameter("telefono")
        );

        if (api.getResponseStatus(responses) == 200) {
            out.print("<script>setTimeout(function(){window.location.href='index.jsp'}, 10);</script>");
        } else {
            out.print("No se pudo actualizar el estudiante.");
        }
    }
%>

</body>
</html>
