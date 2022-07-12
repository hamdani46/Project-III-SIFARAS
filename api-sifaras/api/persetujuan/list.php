<?php

  //Import file
  include '../../config/functions.php';

  // header('Content-Type: text/xml');
  
  $rssql = "SELECT * FROM ijin_cuti WHERE persetujuan = '0'";

  // mendapatkan hasil
  $sql = mysqli_query($con, $rssql);

  // deklarasi array
  $response = array();

  while($a = mysqli_fetch_array($sql)){

    // $idUser = 2;

    $idUser = $a['id_user'];
    $sqlNama = "SELECT * FROM user WHERE id_user = $idUser";

    $sql2 = mysqli_query($con, $sqlNama);
    $nama = mysqli_fetch_array($sql2);
   
    // memasukan data field kedalam variabel
    $b['id_user']         = $a['id_user'];
    $b['id_ijin']         = $a['id_ijin'];
    $b['jenis_ijin']      = $a['jenis_ijin'];
    $b['tanggal_awal']    = $a['tanggal_awal'];
    $b['tanggal_akhir']   = $a['tanggal_akhir'];
    $b['alasan']          = $a['alasan'];
    $b['persetujuan']     = $a['persetujuan'];
    $b['nama']            = $nama['nama_lengkap'];
   
    array_push($response, $b);
  }

  echo json_encode($response);

;?>
