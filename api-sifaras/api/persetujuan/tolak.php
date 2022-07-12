<?php

  //Import file
  include '../../config/functions.php';

  // header('Content-Type: text/xml');

  // Get Data from Form
  $id_ijin           = $_POST['id_ijin'];
  

  // if(!$namaJabatan || !$idJabatan){
  //   $response['success'] = 0;
  //   $response['message'] = "Data kosong";

  //   echo json_encode($response);
  //   return false; 
  // } 

  $hasil  = $db->query(" UPDATE `ijin_cuti` SET `persetujuan`='2' WHERE id_ijin='$id_ijin' ");
  
  if($hasil){
    $response['success'] = 1;
    $response['message'] = "IJin berhasil diupdate";

    echo json_encode($response);
  }else{
    $response['success'] = 0;
    $response['message'] = "Ijin gagal diupdate";

    echo json_encode($response);
  }
;?>
