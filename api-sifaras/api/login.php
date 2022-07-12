<?php

include '../config/functions.php';

$username   = $_POST['username'];
$password   = $_POST['password'];
$namaTabel  = 'user';
// header('Content-Type: text/xml');

$rows = $db->get_results("SELECT * FROM $namaTabel WHERE username = '$username' AND password = '$password'");

// $jumrec = $db->get_var("SELECT COUNT(*) FROM $namaTabel 
//                         WHERE username = '$username' AND password = '$password'");

if ($rows) {
  $response = array();

  foreach ($rows as $row) {
    $response['id_user']  = $row->id_user;
    $response['username'] = $row->username;
    $response['email']    = $row->email;
    $response['status']   = "admin";
    $response['nama_lengkap']   = $row->nama_lengkap;
  }

  $response['success'] = 1;
  $response['message'] = "Berhasil Login!";
  echo json_encode($response);
} else {
  $rows = $db->get_results("SELECT * FROM dokter WHERE username = '$username' AND password = '$password'");

  if ($rows) {
    $response = array();

    foreach ($rows as $row) {
      $response['id_user']  = $row->id_user;
      $response['username'] = $row->username;
      $response['email']    = $row->email;
      $response['status']   = "dokter";
      $response['nama_lengkap']   = $row->nama_lengkap;
    }

    $response['success'] = 1;
    $response['message'] = "Berhasil Login!";
    echo json_encode($response);
  } else {
    $rows = $db->get_results("SELECT * FROM customer WHERE username = '$username' AND password = '$password'");

    if ($rows) {
      $response = array();

      foreach ($rows as $row) {
        $response['id_user']  = $row->id_user;
        $response['username'] = $row->username;
        $response['email']    = $row->email;
        $response['status']   = "customer";
        $response['nama_lengkap']   = $row->nama_lengkap;
      }

      $response['success'] = 1;
      $response['message'] = "Berhasil Login!";
      echo json_encode($response);
    } else {

      $response['success'] = 0;
      $response['message'] = "Tidak ada data";
      echo json_encode($response);
    }

    // $response['success'] = 0;
    // $response['message'] = "Tidak ada data";
    // echo json_encode($response);

  }

  // $response['success'] = 0;
  // $response['message'] = "Tidak ada data";
  // echo json_encode($response);

}
