<?php

include 'conexion.php';
header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');



$respuesta = array();
$resultado='';
$usuarioIniciales;
$idUsuario=0;
$rolUsuario=0;


if (isset($_POST['usuarioCredencial'])){
    if (isset($_POST['claveCredencial'])){
        $usuarioCredencial = $_POST['usuarioCredencial'];
        $claveCredencial = $_POST['claveCredencial'];

        $consultar=$connect->query("SELECT * FROM usuarios WHERE usuarioCredencial='".$usuarioCredencial."' and claveCredencial='".$claveCredencial."' and estadoUsuario = 1");

        
        while($extraerDatos=$consultar->fetch_assoc()){            
            $usuarioIniciales=$extraerDatos['nombreUsuario'].' '.$extraerDatos['apellidoUsuario'];
            $idUsuario = $extraerDatos['idUsuario'];
            $rolUsuario = $extraerDatos['rolUsuario']; 
        }    
        if (empty($usuarioIniciales)){
            $respuesta[] = array('estado'=>false,'mensaje'=>'Credenciales incorrectas','data'=>$resultado); 
        }else{
            $respuesta[] = array('estado'=>true,'mensaje'=>$usuarioIniciales,'data'=>array('idUsuario'=>$idUsuario,'rolUsuario'=>$rolUsuario)); 
        }
        
    }else{
       $respuesta[] = array('estado'=>false,'mensaje'=>'Debe ingresar la clave','data'=>$resultado); 
    }
}else{
   $respuesta[] = array('estado'=>false,'mensaje'=>'Debe ingresar el usuario','data'=>$resultado);        
}

echo json_encode($respuesta);


?>