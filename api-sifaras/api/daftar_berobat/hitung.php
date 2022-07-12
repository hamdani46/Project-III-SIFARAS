<?php

//Import file
include '../../config/functions.php';

// header('Content-Type: text/xml');
// $idUser = $_POST['id_user'];
$idUser = 1;


$result = "SELECT count(*) as total from daftar_berobat WHERE id_dokter=$idUser";
$sqlresult = mysqli_query($con, $result);
$total = mysqli_fetch_assoc($sqlresult);
$jumlah = $total['total'];
// echo $jumlah;
// mendapatkan hasil
$result2 = "SELECT count(*) as total from daftar_berobat WHERE id_dokter=$idUser AND status='dokter'";
$sqlresult2 = mysqli_query($con, $result2);
$ditangani = mysqli_fetch_assoc($sqlresult2);

$jumlah2 = $ditangani['total'];
// echo $jumlah2;

$response = array();

$response['total'] = $jumlah;
$response['ditangani'] = $jumlah2;

array_push($response);
echo json_encode($response);
