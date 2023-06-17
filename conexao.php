<?php
$mysqli_connection = new MySQLi('localhost', 'root', 'Trindade2010@', 'locadora');
if($mysqli_connection->connect_error){
   echo "Desconectado! Erro: " . $mysqli_connection->connect_error;
}else{
   echo "Conectado!";
}
?>