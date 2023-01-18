<?php
include 'conexion.php';

header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');

$queryResult=$connect->query("SELECT a.idMateria, a.idCurso,b.descripcionCurso,b.numeroCurso, a.descripcionMateria,a.docenteMateria, a.imgMateria, a.estadoMateria 
FROM cursos b
inner join materias a on a.idCurso = b.idCurso
where a.idCurso = 2 and  b.estadoCurso = 1 and a.estadoMateria = 1");

$result=array();
$result2=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;
}


$result2[]=array('estado'=>true,'mensaje'=>'Sin novedad','data'=>$result);

echo json_encode( $result2, JSON_UNESCAPED_UNICODE );

?>
