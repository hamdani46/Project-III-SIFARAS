<?php

//Import file
include '../../config/functions.php';

// header('Content-Type: text/xml');
$idUSer = $_POST['id_user'];

// tambah: date untuk where

$rssql = "SELECT * FROM daftar_berobat WHERE id_dokter=$idUSer";

// mendapatkan hasil
$sql = mysqli_query($con, $rssql);

// deklarasi array
$response = array();

while ($a = mysqli_fetch_array($sql)) {

  $id_dokter = $a['id_dokter'];
  $sqldokter = "SELECT * FROM dokter WHERE id_user=$id_dokter";
  $sql2 = mysqli_query($con, $sqldokter);
  $dokter = mysqli_fetch_array($sql2);

  $id_pasien = $a['id_pasien'];
  $sqlpasien = "SELECT * FROM customer WHERE id_user=$id_pasien";
  $sql3 = mysqli_query($con, $sqlpasien);
  $pasien = mysqli_fetch_array($sql3);

  $id_poli = $a['id_poli'];
  $sqlpoli = "SELECT * FROM poli WHERE id_poli=$id_poli";
  $sql4 = mysqli_query($con, $sqlpoli);
  $poli = mysqli_fetch_array($sql4);


  // memasukan data field kedalam variabel
  $b['id_daftar'] = $a['id_daftar'];
  $b['tanggal']   = $a['tanggal'];
  $b['id_pasien'] = $a['id_pasien'];
  $b['id_poli']   = $a['id_poli'];
  $b['id_dokter'] = $a['id_dokter'];
  $b['no_antrian'] = $a['no_antrian'];
  $b['keluhan'] = $a['keluhan'];
  $b['diagnosa'] = $a['diagnosa'];
  $b['obat'] = $a['obat'];
  $b['pemeriksaan'] = $a['pemeriksaan'];
  $b['tindakan'] =  $a['tindakan'];
  $b['status'] = $a['status'];
  $b['nama_dokter'] = $dokter['nama_lengkap'];
  $b['nama_pasien'] = $pasien['nama_lengkap'];
  $b['nama_poli'] = $poli['nama_poli'];


  array_push($response, $b);
}

echo json_encode($response);;
