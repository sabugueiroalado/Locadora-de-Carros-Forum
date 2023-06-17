<?php

include_once("conexao.php");

$MySQLi = $conn;
$query = "SELECT * from usuario";
$result = $MySQLi->query($query);
while($fetch = $result->fetch_assoc()){
        echo "<p>";
        foreach ($fetch as $field => $value){    
        echo $field . '=> ' . $value . ' | ';
}
    echo "</p>";
}
?>