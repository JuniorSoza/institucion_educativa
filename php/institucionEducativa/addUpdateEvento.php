<?php
include 'conexion.php';

header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');

	
	$idEvento = $_POST['idEvento'];
	$descripcionEvento = $_POST['descripcionEvento'];
	$fechaEvento = $_POST['fechaEvento'];
	$horaEvento = $_POST['horaEvento'];
	$lugarEvento = $_POST['lugarEvento'];
	$estadoEvento = $_POST['estadoEvento'];


	$queryResult=$connect->query("SELECT * FROM eventos where idevento = '".$idEvento."'");

	$result=array();
	$result2=array();

	while($fetchData=$queryResult->fetch_assoc()){
		$result[]=$fetchData;
	}

	if(count($result)>=1){ //se actualiza el registro		
		$connect->query("UPDATE eventos SET descripcionEvento='".$descripcionEvento."',fechaEvento='".$fechaEvento."',horaEvento='".$horaEvento."',lugarEvento='".$lugarEvento."',estadoEvento=".$estadoEvento." where idEvento = '".$idEvento."'");		

	}else{ // se ingresa un nuevo registro	
		$connect->query("INSERT INTO eventos (descripcionEvento,fechaEvento, horaEvento, lugarEvento,estadoEvento) VALUES ('".$descripcionEvento."' ,'".$fechaEvento."' , '".$horaEvento."', '".$lugarEvento."', '".$estadoEvento."')");	
	}

	$result2[]=array('estado'=>true,'mensaje'=>'Transacción realizado con éxito','data'=>$result);

	echo json_encode($result2);

?>
