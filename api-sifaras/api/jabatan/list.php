<?php

  //Import file
  include '../../config/functions.php';

  header('Content-Type: text/xml');

  // query sql
  $rssql = "SELECT * FROM jabatan";

  // mendapatkan hasil
  $sql = mysqli_query($con, $rssql);

  // deklarasi array
  $response = array();

  while($a = mysqli_fetch_array($sql)){

    // memasukan data field kedalam variabel
    $b['id_jabatan'] = $a['id_jabatan'];
    $b['nama_jabatan'] = $a['nama_jabatan'];
    $b['log_datetime'] = $a['log_datetime'];

    array_push($response, $b);
  }

  echo json_encode($response);

?>
