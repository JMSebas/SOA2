<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="Quinto.ApiConsumer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.edit-button').click(function () {
                var studentId = $(this).data('student-id');
                $('#exampleModal_' + studentId).modal('show');
            });
        });
    </script>
    <body>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
        <div><jsp:include page="navbar.jsp"/> </div>

        <!-- Formulario de búsqueda por nombre -->
        <form method="GET" action="index.jsp" class="form-inline mb-4">
            <div class="form-group">
                <label for="searchName" class="mr-2">Buscar por Nombre:</label>
                <input type="text" class="form-control mr-2" id="searchName" name="searchName">
                <button type="submit" class="btn btn-primary">Buscar</button>
            </div>
        </form>

        <!-- Formulario de búsqueda por ID -->
        <form method="GET" action="index.jsp" class="form-inline mb-4">
            <div class="form-group">
                <label for="searchId" class="mr-2">Buscar por ID:</label>
                <input type="text" class="form-control mr-2" id="searchId" name="searchId">
                <button type="submit" class="btn btn-primary">Buscar</button>
            </div>
        </form>

        <table class="table">
            <thead>
                <tr>
                    <th scope="col">Cedula</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Apellido</th>
                    <th scope="col">Direccion</th>
                    <th scope="col">Telefono</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ApiConsumer apiConsumer = new ApiConsumer();
                    JSONArray students = new JSONArray();
                    String searchId = request.getParameter("searchId");
                    String searchName = request.getParameter("searchName");

                    if (searchId != null && !searchId.isEmpty()) {
                        JSONObject student = apiConsumer.getStudentById(searchId);
                        if (student.length() > 0) {
                            students.put(student);
                        }
                    } else if (searchName != null && !searchName.isEmpty()) {
                        students = apiConsumer.getStudentsByName(searchName);
                    } else {
                        students = apiConsumer.getStudents();
                    }

                    for (int i = 0; i < students.length(); i++) {
                        JSONObject student = students.getJSONObject(i);
                        String CI = student.getString("cedula");
                        String nombre = student.getString("nombre");
                        String apellido = student.getString("apellido");
                        String direccion = student.getString("direccion");
                        String telefono = student.getString("telefono");
                        String studentId = "student_" + i;
                %>
                <tr>
                    <td> <%= CI %> </td>
                    <td> <%= nombre %> </td>
                    <td> <%= apellido %> </td>
                    <td> <%= direccion %> </td>
                    <td> <%= telefono %> </td>
                    <td>
                        <button type="button" class="btn btn-primary edit-button" data-student-id="<%= studentId %>">
                            Editar
                        </button>
                        <!-- Modal -->
                        <div class="modal fade" id="exampleModal_<%= studentId %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Editar</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <form method="POST" action="editar.jsp" class="p-3">
                                            <div class="form-group">
                                                <label for="cedula">Cedula</label>
                                                <input type="text" class="form-control" id="cedula" name="cedula" value="<%= CI %>" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="nombre">Nombre</label>
                                                <input type="text" class="form-control" id="nombre" name="nombre" value="<%= nombre %>" required="">
                                            </div>
                                            <div class="form-group">
                                                <label for="Apellido">Apellido</label>
                                                <input type="text" class="form-control" id="apellido" name="apellido" value="<%= apellido %>" required="">
                                            </div>
                                            <div class="form-group">
                                                <label for="Direccion">Direccion</label>
                                                <input type="text" class="form-control" id="direccion" name="direccion" value="<%= direccion %>" required="">
                                            </div>
                                            <div class="form-group">
                                                <label for="telefono">Telefono</label>
                                                <input type="text" class="form-control" id="telefono" name="telefono" value="<%= telefono %>" required="">
                                            </div>

                                            <button type="submit" class="btn btn-primary my-3">Editar</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>
                        <a href="eliminar.jsp?cedula=<%= CI %>" class="btn btn-danger">Eliminar</a>
                    </td>            
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </body>
</html>
