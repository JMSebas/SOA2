<?php
include_once 'conexion.php';

class CrudS {
    public static function seleccionarEstudiantes() {
        $query = "SELECT * FROM estudiante";
        $result = self::executeQuery($query);
        echo json_encode($result->fetchAll(PDO::FETCH_ASSOC));
    }

    public static function seleccionarEstudiantePorCedula($cedula) {
        $query = "SELECT * FROM estudiante WHERE cedula = :cedula";
        $result = self::executeQuery($query, ['cedula' => $cedula]);
        echo json_encode($result->fetch(PDO::FETCH_ASSOC));
    }

    public static function seleccionarEstudiantesPorNombre($nombre) {
        $query = "SELECT * FROM estudiante WHERE nombre LIKE :nombre";
        $result = self::executeQuery($query, ['nombre' => '%' . $nombre . '%']);
        echo json_encode($result->fetchAll(PDO::FETCH_ASSOC));
    }

    private static function executeQuery($query, $params = []) {
        try {
            $pdo = new PDO('mysql:host=localhost;dbname=quinto', 'root', '');
            $stmt = $pdo->prepare($query);
            $stmt->execute($params);
            return $stmt;
        } catch (PDOException $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
            exit();
        }
    }
}

?>
