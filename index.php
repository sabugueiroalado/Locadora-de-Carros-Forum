<?php
session_start();
?>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="utf-8">
        <title>APS</title>
    <head>
    <body>
        <h1>Cadastrar</h1>
        <?php
        if(isset($_SESSION['msg'])){
        echo $_SESSION['msg'];
        unset($_SESSION['msg']);
        }
        ?>
        <form method="POST" action="processa.php">
            <label>Nome: </label>
            <input type="text" name="nome" placeholder="Digite o nome completo"><br><br>

            <label>Email: </label>
            <input type="email" name="email" placeholder="Digite o seu Email"><br><br>
        
            <input type="submit" value="Cadastrar">
        </form>
        <form method="get" action="relatorio.php">       
        <input type="submit" value="Relatório">
        </form>
        <form method="get" action="consulta.php">
        <input type="submit" value="Consultar">
        </form>  
  </body>
</html>