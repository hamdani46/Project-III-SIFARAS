<?php

  //Import file
  include '../../config/functions.php';

  // header('Content-Type: text/xml');

  // Get Data from Form
  $id_ijin     = $_POST['id_ijin'];

  $hasil = $db->query("DELETE FROM `ijin_cuti` WHERE id_ijin='$id_ijin'");

  if($hasil){
    $response['success'] = 1;
    $response['message'] = "Berhasil dihapus id:$idUser";

    echo json_encode($response);
  }else{
    $response['success'] = 0;
    $response['message'] = "Data gagal dihapus";

    echo json_encode($response);
  }
  
?>
