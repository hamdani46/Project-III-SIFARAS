<?php

$config["server"]='localhost';
$config["username"]='root';
$config["password"]='';
$config["database_name"]='sifaras';

////SERVER
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');	
define('DB_NAME', 'sifaras');

 //membuat koneksi dengan database
 $con = mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME) or die('Unable to Connect');

;?>