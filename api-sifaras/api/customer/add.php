<?php

  include '../../config/functions.php';
  
  // header('Content-Type: text/xml');

  $namaTabel = "customer";

  // Get Data from Form 
  $username          = $_POST['user_name'];
  $password          = $_POST['password'];
  $email             = $_POST['email'];
  $nama              = $_POST['nama_lengkap'];
  $jenis_kelamin     = $_POST['jenis_kelamin'];
  $tanggal_lahir     = $_POST['tanggal_lahir'];
  
 

  // Insert data
  $sql = $db->query("INSERT INTO `customer`(`id_user`, `username`, `password`, `email`, `nama_lengkap`, `jenis_kelamin`, `tanggal_lahir`, `log_datetime`) VALUES (NULL,'$username','$password','$email',' $nama','$jenis_kelamin','$tanggal_lahir',now())");

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