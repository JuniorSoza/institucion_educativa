<?php

	include 'conexion.php';
	header('access-control-allow-origin: *');
	header('Access-Control-Allow-Headers: *');
	
	try {

		$respuesta = array();


		$connect->query("INSERT INTO `usuarios` (`idUsuario`, `nombreUsuario`, `apellidoUsuario`, `cedulaUsuario`, `usuarioCredencial`, `claveCredencial`, `rolUsuario`, `estadoUsuario`) VALUES (NULL, '".$_POST['nombreUsuario']."' , '".$_POST['apellidoUsuario']."', '".$_POST['cedulaUsuario']."', '".$_POST['usuarioCredencial']."', '".$_POST['claveCredencial']."', '".$_POST['rolUsuario']."', '1')");
				
				
		$respuesta[] = array('estado'=>true,'mensaje'=>'Ingreso exitoso','data'=>[]); 
		

	} catch (Exception $e) {
		$respuesta[] = array('estado'=>false,'mensaje'=>$e->getMessage(),'data'=>[]);	    
	}

echo json_encode($respuesta);

?>