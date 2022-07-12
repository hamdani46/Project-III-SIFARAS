<?php

//Import file
include '../../config/functions.php';

// header('Content-Type: text/xml');

// Get Data from Form
$id_daftar    = $_POST['id_daftar'];
$diagnosa     = $_POST['diagnosa'];
$obat         = $_POST['obat'];
$pemeriksaan  = $_POST['pemeriksaan'];
$tindakan     = $_POST['tindakan'];
$status       = "dokter";

$hasil  = $db->query("UPDATE `daftar_berobat` SET `diagnosa`='$diagnosa',`obat`='$obat',`pemeriksaan`='$pemeriksaan',`tindakan`='$tindakan',`status`='$status' WHERE `id_daftar`='$id_daftar' ");

if ($hasil) {
  $response['success'] = 1;
  $response['message'] = "IJin berhasil diupdate";

  echo json_encode($response);
} else {
  $response['success'] = 0;
  $response['message'] = "Ijin gagal diupdate";

  echo json_encode($response);
};
