<?php
include 'conexion.php';

header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');

$opcion = $_POST['opcion'];
$filtro = @$_POST['filtro'];
$queryResult = '';

	if($opcion == "MATERIA"){
		$queryResult=$connect->query("SELECT idMateria,descripcionMateria FROM materias 
		where estadoMateria = 1 and idCurso = ".$filtro."");
	} else if ($opcion == "ALUMNO"){
		$queryResult=$connect->query("SELECT idAlumno, CONCAT(nombreAlumno,' ',apellidoAlumno) as descripcionAlumno 
		FROM alumnos where estadoAlumno = 1 and idCurso = ".$filtro."");
	}
	

$result=array();
$result2=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;//array_map("utf8_encode",$fetchData);
}


$result2[]=array('estado'=>true,'mensaje'=>'Sin novedad','data'=>$result);


echo json_encode( $result2, JSON_UNESCAPED_UNICODE );

?>
