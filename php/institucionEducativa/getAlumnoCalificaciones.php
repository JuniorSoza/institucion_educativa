<?php
include 'conexion.php';

header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');

$idMateria = $_POST['idMateria'];
$idAlumno = $_POST['idAlumno'];

$queryResult=$connect->query("SELECT * FROM calificaciones 
where idMateria = '".$idMateria."' and idAlumno = '".$idAlumno."' and estadoCalificacion=1
order by idCalificacion asc");

$result=array();
$result2=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;
}


$result2[]=array('estado'=>true,'mensaje'=>'Sin novedad','data'=>$result);


echo json_encode( $result2, JSON_UNESCAPED_UNICODE );

?>