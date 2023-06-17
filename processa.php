<?php
session_start();
include_once("conexao.php");

$nome = filter_input(INPUT_POST, 'nome', FILTER_SANITIZE_STRING);
$email = filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL);

$result_usuario = "INSERT INTO usuario(nome, email, criada) VALUES('$nome','$email', NOW())";
$resultado_usuario = mysqli_query($conn, $result_usuario);

if(mysqli_insert_id($conn)){
    $_SESSION['msg'] = "<p style='color:green'> Usuário Cadastrado Com Sucesso!</p>";
    header("Location: index.php");
}else{
 $_SESSION['msg'] = "<p style='color:green'> Usuário Não foi Cadastrado Com Sucesso!</p>";
    header("Location: index.php");
}
?>