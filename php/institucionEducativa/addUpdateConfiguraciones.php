<?php
include 'conexion.php';

header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');

	
	$nombreInstitucion = $_POST['nombreInstitucion'];
	$ubicacionInstitucion = $_POST['ubicacionInstitucion'];
	$misionInstitucion = $_POST['misionInstitucion'];
	$visionInstitucion = $_POST['visionInstitucion'];


	$queryResult=$connect->query("SELECT * FROM configuraciones");

	$result=array();
	$result2=array();

	while($fetchData=$queryResult->fetch_assoc()){
		$result[]=$fetchData;
	}

	if(count($result)>=1){ //se actualiza el registro		
		$connect->query("UPDATE configuraciones SET nombreInstitucion='".$nombreInstitucion."',ubicacionInstitucion='".$ubicacionInstitucion."',misionInstitucion='".$misionInstitucion."',visionInstitucion='".$visionInstitucion."'");		

	}else{ // se ingresa un nuevo registro	
		$connect->query("INSERT INTO configuraciones (nombreInstitucion,ubicacionInstitucion, misionInstitucion, visionInstitucion) VALUES ('".$nombreInstitucion."' ,'".$ubicacionInstitucion."' , '".$misionInstitucion."', '".$visionInstitucion."')");	
	}

	$result2[]=array('estado'=>true,'mensaje'=>'Transacción realizado con éxito','data'=>$result);

	echo json_encode($result2);

?>
