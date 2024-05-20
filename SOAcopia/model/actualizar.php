<?php
 include_once 'conexion.php';

 class CrudM{
     public static function modificarEstudiante($ced_est, $nom_est, $ape_est, $dir_est, $tel_est){
         $object = new conexion();
         $conectar = $object->conectar();
         $update = "update estudiante set nombre='$nom_est',apellido='$ape_est', direccion='$dir_est', telefono='$tel_est' where cedula='$ced_est'";
         $result= $conectar->prepare($update);
         $result->execute();
         echo json_encode($result);
         $conectar->commit();
     }
 }