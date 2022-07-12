<?php

  //Import file
  include '../../config/functions.php';

  header('Content-Type: text/xml');

  $namaTabel = "poli";

  // Get Data from Form
  $idPoli     = $_POST['id_poli'];

  $hasil = $db->query("DELETE FROM $namaTabel WHERE id_poli='$idPoli'");

  if($hasil){
    $response['success'] = 1;
    $response['message'] = "Berhasil dihapus";

    echo json_encode($response);
  }else{
    $response['success'] = 0;
    $response['message'] = "Data gagal dihapus";

    echo json_encode($response);
  }
  
?>
