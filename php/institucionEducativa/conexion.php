<?php

$connect = new mysqli("localhost","root","","institucioneducativa");
$connect->set_charset('utf8');
if($connect){
	 
}else{
	echo "Fallo, revise ip o firewall";
	exit();
}
