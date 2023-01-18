<?php
include 'conexion.php';

header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');

$queryResult=$connect->query("SELECT idCurso,descripcionCurso FROM cursos where estadoCurso = 1");

$result=array();
$result2=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;
}


$result2[]=array('estado'=>true,'mensaje'=>'Sin novedad','data'=>$result);


echo json_encode( $result2, JSON_UNESCAPED_UNICODE );

?>
