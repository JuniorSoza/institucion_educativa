<?php
include 'conexion.php';
//header('Content-Type: application/json;charset=utf-8');  
header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');


$idUsuario = $_POST['idUsuario'];

$queryResult=$connect->query("select a.idAlumno,a.nombreAlumno,a.apellidoAlumno,b.descripcionCurso,b.numeroCurso,c.idMateria,c.descripcionMateria,c.docenteMateria,c.imgMateria
from alumnos a 
inner join cursos b on b.idCurso = a.idCurso
inner join materias c on b.idCurso = c.idCurso
where a.estadoAlumno=1 and a.idUsuario = '".$idUsuario."'
order by b.numeroCurso ASC");

$result=array();
$result2=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;//array_map("utf8_encode", $fetchData);
}


$result2[]=array('estado'=>true,'mensaje'=>'','data'=>$result);

echo json_encode( $result2, JSON_UNESCAPED_UNICODE );


?>
