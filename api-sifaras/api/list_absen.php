<?php
  include '../config/functions.php';

  header('Content-Type: text/xml');

  $idUSer = $_POST['id_user'];
  $intervalDay = $_POST['intervalDay'];

  (!$intervalDay) ? $intervalDay = 7 : $intervalDay = $intervalDay;

  // query sql
  $rssql = "SELECT * FROM log_absen WHERE id_karyawan=$idUSer ORDER BY date DESC LIMIT $intervalDay";
  $sql = mysqli_query($con, $rssql);

  // deklarasi var array - menyimpan data raw db
    $raw = array();

    while($a = mysqli_fetch_array($sql)){

      // memasukan data field kedalam variabel
      $b['id_absen'] = $a['id_absen'];
      $b['id_karyawan'] = $a['id_karyawan'];
      $b['date'] = $a['date'];
      $b['jam_masuk'] = $a['jam_masuk'];
      $b['jam_pulang'] = $a['jam_pulang'];
      $b['Keterangan'] = $a['Keterangan'];

      array_push($raw, $b);
    }

  // deklarasi var array - menyimpan data untuk response
    $response = array();

  // declare tanggal sekarang dan hari ke belakang
    $dateNow = date('Y-m-d'); // "22-06-05"
    $startDate = date("Y-m-d", strtotime("-".$intervalDay." days"));

  // perualangan tanggal
    while(strtotime($startDate) <= strtotime($dateNow)){
      $item['date'] = $startDate;

        // pencocokan tanggal dengan data yg ada di database
        foreach($raw as $a){

          // jika di tgl tersebut ada data
          if($startDate == $a['date']){
            $item['id_absen'] = $a['id_absen'];
            $item['jam_masuk'] = $a['jam_masuk'];
            $item['jam_pulang'] = $a['jam_pulang'];
            $item['Keterangan'] = $a['Keterangan'];
            break;
          } 
          // jika di tgl tersebut tidak ada data 
          else{
            $item['id_absen'] = "-";
            $item['jam_masuk']  = "-";
            $item['jam_pulang'] = "-";
            $item['Keterangan'] = "Tidak Masuk";
          }
        
        }
      // masukan object ke var array response
      array_push($response, $item);

      $startDate = date("Y-m-d", strtotime("+1 days", strtotime($startDate)));

    }

  echo json_encode($response);

?>
