<?php

include '../config/functions.php';

$id_user    = $_POST['id_user'];
$date       = $_POST['date'];
$namaTabel  = 'log_absen';
// header('Content-Type: text/xml');

$rows = $db->get_results("SELECT * FROM $namaTabel WHERE id_karyawan = '$id_user' AND date = '$date'");


if($rows){
  $response = array();

  foreach ($rows as $row) {
    $response['date']  = $row->date;
    
  }

  $response['success'] = 1;
  $response['message'] = "data ditemukan";
  echo json_encode($response);
} else{
  $response['success'] = 0;
  $response['message'] = "Tidak ada data";
  echo json_encode($response);

}



?>