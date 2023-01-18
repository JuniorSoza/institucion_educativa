<?php

	include 'conexion.php';
	header('access-control-allow-origin: *');
	header('Access-Control-Allow-Headers: *');
	
	try {

		$respuesta = array();


		$connect->query("INSERT INTO `alumnos` (`idAlumno`, `nombreAlumno`, `apellidoAlumno`, `cedulaAlumno`, `idUsuario`, `idCurso`, `estadoAlumno`) VALUES (NULL, '".$_POST['nombreAlumno']."' , '".$_POST['apellidoAlumno']."', '".$_POST['cedulaAlumno']."', '".$_POST['idUsuario']."', '".$_POST['idCurso']."', '1')");
				
				
		$respuesta[] = array('estado'=>true,'mensaje'=>'Ingreso exitoso','data'=>[]); 
		

	} catch (Exception $e) {
		$respuesta[] = array('estado'=>false,'mensaje'=>$e->getMessage(),'data'=>[]);	    
	}

echo json_encode($respuesta);

?>