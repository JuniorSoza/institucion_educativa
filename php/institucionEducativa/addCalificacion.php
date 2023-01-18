<?php

	include 'conexion.php';
	header('access-control-allow-origin: *');
	header('Access-Control-Allow-Headers: *');
	
	try {

		$respuesta = array();


		$connect->query("INSERT INTO `calificaciones` (`idCalificacion`, `idMateria`, `idAlumno`, `notaCalificacion`, `sobreCalificacion`, `descripcionCalificacion`, `estadoCalificacion`) 
		VALUES (NULL, '".$_POST['idMateria']."' , '".$_POST['idAlumno']."', '".$_POST['notaCalificacion']."', '".$_POST['sobreCalificacion']."', '".$_POST['descripcionCalificacion']."', '1')");
				
				
		$respuesta[] = array('estado'=>true,'mensaje'=>'Ingreso exitoso','data'=>[]); 
		

	} catch (Exception $e) {
		$respuesta[] = array('estado'=>false,'mensaje'=>$e->getMessage(),'data'=>[]);	    
	}

echo json_encode($respuesta);

?>