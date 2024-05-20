package Quinto;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

public class ApiConsumer {
    private final HttpClient httpClient;
    private static String url = "http://localhost/SOAcopia/controller/apiRest.php";
    
    public ApiConsumer() {
        this.httpClient = HttpClient.newHttpClient();
    }
    
    public JSONArray getStudents() throws Exception {
        HttpRequest request = HttpRequest.newBuilder().uri(URI.create(url)).GET().build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        return new JSONArray(response.body());
    }
    
    public JSONObject getStudentById(String cedula) throws Exception {
        HttpRequest request = HttpRequest.newBuilder().uri(URI.create(url + "?cedula=" + cedula)).GET().build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        return new JSONObject(response.body());
    }
    
    public JSONArray getStudentsByName(String nombre) throws Exception {
        HttpRequest request = HttpRequest.newBuilder().uri(URI.create(url + "?nombre=" + nombre)).GET().build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        return new JSONArray(response.body());
    }

    public HttpResponse<String> postStudent(String cedula, String nombre, String apellido, String direccion, String telefono) {
        try {
            JSONObject student = new JSONObject();
            student.put("cedula", cedula);
            student.put("nombre", nombre);
            student.put("apellido", apellido);
            student.put("direccion", direccion);
            student.put("telefono", telefono);
            
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(student.toString()))
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return response;
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(ApiConsumer.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public HttpResponse<String> delete(String id) {
        try {
            URI uri = URI.create(url + "?cedula=" + id);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(uri)
                    .DELETE()
                    .build();
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return response;
        } catch (Exception ex) {
            System.out.println("Error: " + ex);
        }
        return null;
    }
    
    public HttpResponse<String> update(String id, String name, String lastname, String address, String phone) {
        try {
            JSONObject student = new JSONObject();
            student.put("cedula", id);
            student.put("nombre", name);
            student.put("apellido", lastname);
            student.put("direccion", address);
            student.put("telefono", phone);
            
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Content-Type", "application/json")
                    .PUT(HttpRequest.BodyPublishers.ofString(student.toString()))
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return response;
        } catch (Exception ex) {
            System.out.println("Error: " + ex);
        }
        return null;
    }
    
    public int getResponseStatus(HttpResponse<String> response) {
        return response.statusCode();
    }
}
