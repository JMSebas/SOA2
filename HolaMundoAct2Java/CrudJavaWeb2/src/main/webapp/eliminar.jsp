<%-- 
    Document   : eliminar
    Created on : May 13, 2024, 12:17:36 PM
    Author     : Adri
--%>

<%@page import="java.net.http.HttpResponse"%>
<%@page import="Quinto.ApiConsumer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ID = request.getParameter("cedula");
    ApiConsumer api = new ApiConsumer();
    HttpResponse<String> responses = api.delete(ID);
    if (api.getResponseStatus(responses) == 200) {
            response.sendRedirect("index.jsp");
    } else {
        out.print("<div>No se pudo eliminar el estudiante</div>");
    }
%>
