<?php
include 'conexion.php';

header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');

$queryResult=$connect->query("SELECT idUsuario, CONCAT(nombreUsuario,' ',apellidoUsuario) as descripcionUsuario 
from usuarios where estadoUsuario = 1 
and rolUsuario = 'PADRE'
and idUsuario not in (select idUsuario from alumnos)");

$result=array();
$result2=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;
}


$result2[]=array('estado'=>true,'mensaje'=>'Sin novedad','data'=>$result);

//echo json_encode($result2);
echo json_encode( $result2, JSON_UNESCAPED_UNICODE );


?>
