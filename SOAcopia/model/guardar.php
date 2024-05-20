<?php
include_once 'conexion.php';

class CrudG{
    public static function guardarEstudiante($ced_est,$nom_est,$ape_est, $dir_est, $tel_est){
        $object = new conexion();
        $conectar = $object->conectar();
        $insert = "insert into estudiante values('$ced_est','$nom_est','$ape_est', '$dir_est', '$tel_est')";
        $result= $conectar->prepare($insert);
        $result->execute();
        $dataJs = json_encode($result);
        print_r($dataJs);
        //echo json_encode($result);
        $conectar->commit();
    }
}