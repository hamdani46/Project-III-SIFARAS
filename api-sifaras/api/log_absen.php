<?php

  //Import file
  include '../config/functions.php';

  // Get Data from Form
 
  $id_user = $_POST['id_user'];
  $date      = $_POST['date'];
  $jam_masuk  = $_POST['jam_datang'];
  
  $Jam_pulang  = $_POST['jam_pulang'];
  $keterangan  = $_POST['ket'];
  

  header('Content-Type: text/xml');

  $nama_tabel     = 'log_absen';
  $hasil  = $db->query("INSERT INTO $nama_tabel VALUES(NULL, '$id_user', '$date', '$jam_masuk', '$Jam_pulang', '$keterangan')");

  if($hasil){
    $response['success'] = 1;
    $response['message'] = "Berhasil disimpan";

    echo json_encode($response);
  }else{
    $response['success'] = 0;
    $response['message'] = "Data gagal disimpan";

    echo json_encode($response);
  }
;?>
