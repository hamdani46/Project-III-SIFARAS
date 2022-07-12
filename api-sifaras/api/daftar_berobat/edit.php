<?php

//Import file
include '../../config/functions.php';

// header('Content-Type: text/xml');

// Get Data from Form
$id_ijin           = $_POST['id_ijin'];
$jenis_ijin        = $_POST['jenis_ijin'];
$tanggal_awal      = $_POST['tanggal_awal'];
$tanggal_akhir     = $_POST['tanggal_akhir'];
$alasan            = $_POST['alasan'];



$hasil  = $db->query(" UPDATE `ijin_cuti` SET `jenis_ijin`='$jenis_ijin',`tanggal_awal`='$tanggal_awal',`tanggal_akhir`='$tanggal_akhir',`alasan`='$alasan' WHERE id_ijin='$id_ijin' ");

if ($hasil) {
  $response['success'] = 1;
  $response['message'] = "IJin berhasil diupdate";

  echo json_encode($response);
} else {
  $response['success'] = 0;
  $response['message'] = "Ijin gagal diupdate";

  echo json_encode($response);
};
