<?php
include_once("conexao.php"); 

$MySQLi = $conn;
$nome1 = filter_input(INPUT_POST, 'nome2', FILTER_SANITIZE_STRING);
$query = "SELECT nome from usuario WHERE nome = '$nome1'";
$result = $MySQLi->query($query);
while($fetch = $result->fetch_assoc()){
    echo "<p>";
    foreach ($fetch as $field => $value){
    echo $fetcho . '=> ' . $value . ' | ';
}
echo "</p>";
}

?>