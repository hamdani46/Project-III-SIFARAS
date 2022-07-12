<?php

  //Import file
  include '../../config/functions.php';

  // header('Content-Type: text/xml');

  // Get Data from Form
  $idUser     = $_POST['id_user'];
  $namaLengkap    = $_POST['nama_lengkap'];
  $jenisKelamin   = $_POST['jenis_kelamin'];
  $tanggalLahir   = $_POST['tanggal_lahir'];
  $tanggalGabung   = $_POST['tanggal_gabung'];
  $idJabatan = $_POST['id_jabatan'];

  // if(!$namaJabatan || !$idJabatan){
  //   $response['success'] = 0;
  //   $response['message'] = "Data kosong";

  //   echo json_encode($response);
  //   return false; 
  // } 

  $hasil  = $db->query(" UPDATE user SET nama_lengkap = '$namaLengkap', id_jabatan = '$idJabatan', 
                         jenis_kelamin = '$jenisKelamin', tanggal_lahir ='$tanggalLahir', tanggal_gabung = '$tanggalGabung'
                         WHERE id_user='$idUser' ");
  
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
