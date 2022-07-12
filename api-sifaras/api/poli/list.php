<?php

  //Import file
  include '../../config/functions.php';

  header('Content-Type: text/xml');

  // query sql
  $rssql = "SELECT * FROM poli";

  // mendapatkan hasil
  $sql = mysqli_query($con, $rssql);

  // deklarasi array
  $response = array();

  while($a = mysqli_fetch_array($sql)){

    // memasukan data field kedalam variabel
    $b['id_poli'] = $a['id_poli'];
    $b['nama_poli'] = $a['nama_poli'];
    $b['log_datetime'] = $a['log_datetime'];

    array_push($response, $b);
  }

  echo json_encode($response);

?>
