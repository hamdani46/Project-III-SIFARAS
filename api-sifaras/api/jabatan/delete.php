<?php

  //Import file
  include '../../config/functions.php';

  header('Content-Type: text/xml');

  $namaTabel = "jabatan";

  // Get Data from Form
  $idJabatan     = $_POST['id_jabatan'];

  $hasil = $db->query("DELETE FROM $namaTabel WHERE id_jabatan='$idJabatan'");

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
