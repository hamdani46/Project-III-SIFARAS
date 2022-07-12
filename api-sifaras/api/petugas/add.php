<?php

  include '../../config/functions.php';
  
  // header('Content-Type: text/xml');

  $namaTabel = "user";

  // Get Data from Form 
  $username          = $_POST['user_name'];
  $password          = $_POST['password'];
  $email             = $_POST['email'];
  $status            = $_POST['status'];
  $nama              = $_POST['nama_lengkap'];
  $id_user           = $_POST['id_user'];
  $jenis_kelamin     = $_POST['jenis_kelamin'];
  $tanggal_lahir     = $_POST['tanggal_lahir'];
  $id_jabatan        = $_POST['id_jabatan'];
  $tanggal_gabung    = $_POST['tanggal_gabung'];
  $alamat           = $_POST['alamat'];


  // $pangkat           = "tes";
  // // $masa_kerja        = "5";
  // $status_kawin      = "ok";
  // $bpjs              = "ok";
 

  // if(!$namaJabatan){
  //   $response['success'] = 0;
  //   $response['message'] = "Data kosong";
  //   echo json_encode($response);
  //   return die(); 
  // } 

  // $cek = $db->get_results("SELECT * FROM `$namaTabel` WHERE `nama_jabatan` = '$namaJabatan'");

  // // Cek data sudah ada?
  // if($cek){
  //   $response['success'] = 0;
  //   $response['message'] = "Data sudah ada";
  //   echo json_encode($response);
  //   return die(); 
  // }

  // Insert data
  $sql = $db->query("INSERT INTO $namaTabel (`username`, `password`, `email`, `status`, `nama_lengkap`, `jenis_kelamin`, `tanggal_lahir`, `id_jabatan`, `tanggal_gabung`, `alamat`, `log_datetime`) VALUES('$username','$password','$email','$status','$nama','$jenis_kelamin','$tanggal_lahir','$id_jabatan','$tanggal_gabung','$alamat',NOW())");

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