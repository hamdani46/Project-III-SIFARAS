<?php

  //Import file
  include '../../config/functions.php';

  // header('Content-Type: text/xml');

  
  $rssql = "SELECT * FROM customer";

  // mendapatkan hasil
  $sql = mysqli_query($con, $rssql);

  // deklarasi array
  $response = array();

  while($a = mysqli_fetch_array($sql)){
   
    

    // memasukan data field kedalam variabel
    $b['id_user']     = $a['id_user'];
    $b['nama_lengkap']    = $a['nama_lengkap'];
    $b['jenis_kelamin']   = $a['jenis_kelamin'];
    $b['tanggal_lahir']   = $a['tanggal_lahir'];
    $b['log_datetime']    = $a['log_datetime'];

    array_push($response, $b);
  }

  echo json_encode($response);

;?>
