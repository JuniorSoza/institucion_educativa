<?php
include 'conexion.php';

header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');

$queryResult=$connect->query("SELECT * from configuraciones");

$result=array();
$result2=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=array_map("utf8_encode",$fetchData);
}


$result2[]=array('estado'=>true,'mensaje'=>'Sin novedad','data'=>$result);

echo json_encode($result2);

?>
