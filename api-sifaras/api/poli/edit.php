<?php

  //Import file
  include '../../config/functions.php';

  // header('Content-Type: text/xml');

  // Get Data from Form
  $idPoli     = $_POST['id_poli'];
  $namaPoli    = $_POST['namaPoli'];

  if(!$namaPoli || !$idPoli){
    $response['success'] = 0;
    $response['message'] = "Data kosong";

    echo json_encode($response);
    return false; 
  } 

  $hasil  = $db->query(" UPDATE poli SET nama_poli = '$namaPoli', log_datetime = NOW() 
                         WHERE id_poli='$idPoli' ");
  
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
