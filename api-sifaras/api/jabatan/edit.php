<?php

  //Import file
  include '../../config/functions.php';

  // header('Content-Type: text/xml');

  // Get Data from Form
  $idJabatan     = $_POST['id_jabatan'];
  $namaJabatan    = $_POST['namaJabatan'];

  if(!$namaJabatan || !$idJabatan){
    $response['success'] = 0;
    $response['message'] = "Data kosong";

    echo json_encode($response);
    return false; 
  } 

  $hasil  = $db->query(" UPDATE jabatan SET nama_jabatan = '$namaJabatan', log_datetime = NOW() 
                         WHERE id_jabatan='$idJabatan' ");
  
  if($hasil){
    $response['success'] = 1;
    $response['message'] = "Berhasil diupdate";

    echo json_encode($response);
  }else{
    $response['success'] = 0;
    $response['message'] = "Data gagal diupdate";

    echo json_encode($response);
  }
;?>
