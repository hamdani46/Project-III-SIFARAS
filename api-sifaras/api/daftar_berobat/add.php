<?php

include '../../config/functions.php';

// header('Content-Type: text/xml');

// Get Data from Form 
$tanggal           = $_POST['tanggal'];
$id_pasien         = $_POST['id_pasien'];
$id_poli           = $_POST['id_poli'];
$id_dokter         = $_POST['id_dokter'];
$keluhan           = $_POST['keluhan'];

$tanggalcari = date("Y-m-d", strtotime($tanggal));
$tanggalcari2 = "'$tanggalcari'";

$id_pasien_query = " AND id_pasien=$id_pasien";

function hitung($con, $tanggalcari2, $id_poli, $id_pasien_query)
{
  $result = "SELECT count(*) as total from daftar_berobat WHERE `tanggal`=$tanggalcari2 AND `id_poli`=$id_poli $id_pasien_query";
  $sqlresult = mysqli_query($con, $result);
  $data = mysqli_fetch_assoc($sqlresult);
  $jumlah = $data['total'];

  // $jumlah = 1;

  return $jumlah;
}

$jumlah = hitung($con, $tanggalcari2, $id_poli, $id_pasien_query);
// echo $jumlah;

$response = array();

if ($jumlah > 0) {
  $response['success'] = 0;
  $response['message'] = "Anda Sudah Mendaftar pada poli ini";
  echo json_encode($response);
} else {
  $id_pasien_query = "";
  $jumlah = hitung($con, $tanggalcari2, $id_poli, $id_pasien_query);
  // echo "no antrian: " + $jumlah;

  $no_antrian        = $jumlah + 1;
  echo ("no antrian $no_antrian");

  $sql = $db->query("INSERT INTO `daftar_berobat`(`id_daftar`, `tanggal`, `id_pasien`, `id_poli`, `id_dokter`, `no_antrian`, `keluhan`) VALUES (NULL,'$tanggal','$id_pasien','$id_poli','$id_dokter','$no_antrian','$keluhan')");

  if ($sql) {
    $response['success'] = 1;
    $response['message'] = "Berhasil Tambah Ijin";
    echo json_encode($response);
  } else {
    $response['success'] = 0;
    $response['message'] = "Ijin Gagal Disimpan";
    echo json_encode($response);
  }
}
