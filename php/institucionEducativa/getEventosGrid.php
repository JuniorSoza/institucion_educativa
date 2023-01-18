<?php
include 'conexion.php';

header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');

$queryResult=$connect->query("SELECT * FROM eventos order by idEvento desc");

$result=array();
$result2=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;
}


$result2[]=array('estado'=>true,'mensaje'=>'Sin novedad','data'=>$result);

echo json_encode( $result2, JSON_UNESCAPED_UNICODE );

?>
