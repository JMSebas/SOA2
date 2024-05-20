<?php
include_once 'conexion.php';

class CrudE{
    public static function eliminarEstudiante($ced_est){
        $object = new conexion();
        $conectar = $object->conectar();
        $borrar = "delete from estudiante where cedula='$ced_est'";
        $result = $conectar->prepare($borrar);
        $result -> execute();
        echo json_encode($result);
        $conectar->commit();
    }
}