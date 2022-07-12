<?php

  include '../../config/functions.php';
  
  // header('Content-Type: text/xml');

  $namaTabel = "poli";

  // Get Data from Form 
  $namaPoli     = $_POST['namaPoli'];

  if(!$namaPoli){
    $response['success'] = 0;
    $response['message'] = "Data kosong";
    echo json_encode($response);
    return die(); 
  } 

  $cek = $db->get_results("SELECT * FROM `$namaTabel` WHERE `nama_poli` = '$namaPoli'");

  // Cek data sudah ada?
  if($cek){
    $response['success'] = 0;
    $response['message'] = "Data sudah ada";
    echo json_encode($response);
    return die(); 
  }

  // Insert data
  $sql = $db->query("INSERT INTO $namaTabel VALUES(NULL,'$namaPoli', NOW())");

  if($sql){
    $response['success'] = 1;
    $response['message'] = "Berhasil Tambah Data";
    echo json_encode($response);
  }else{
    $response['success'] = 0;
    $response['message'] = "Data Gagal Disimpan";
    echo json_encode($response);
  }

?>