<?php

  //Import file
  include '../../config/functions.php';

  // header('Content-Type: text/xml');

  // Get Data from Form
  $idUser     = $_POST['id_user'];

  $hasil = $db->query("DELETE FROM `customer` WHERE id_user='$idUser'");

  if($hasil){
    $response['success'] = 1;
    $response['message'] = "Berhasil dihapus id:$idUser";

    echo json_encode($response);
  }else{
    $response['success'] = 0;
    $response['message'] = "Data gagal dihapus ya";

    echo json_encode($response);
  }
  
?>
