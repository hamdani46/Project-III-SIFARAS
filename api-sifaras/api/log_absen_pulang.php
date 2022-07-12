<?php

  //Import file
  include '../config/functions.php';

  // Get Data from Form
 
  $id_user = $_POST['id_user'];
  $date      = $_POST['date'];
  $jam_pulang  = $_POST['jam_pulang'];
  
  

  header('Content-Type: text/xml');

  $nama_tabel     = 'log_absen';
  $hasil  = $db->query("UPDATE $nama_tabel SET jam_pulang = '$jam_pulang'
  WHERE id_karyawan='$id_user' AND date='$date'");

  if($hasil){
    $response['success'] = 1;
    $response['message'] = "pulang Berhasil disimpan";

    echo json_encode($response);
  }else{
    $response['success'] = 0;
    $response['message'] = "pulang gagal disimpan";

    echo json_encode($response);
  }
;?>
