<?php

  //Import file
  include '../../config/functions.php';

  // header('Content-Type: text/xml');

  // Get Data from Form
  $id_ijin           = $_POST['id_ijin'];
  $id_user           = $_POST['id_user'];
  $jenis_ijin        = $_POST['jenis_ijin'];
  $tanggal_awal      = $_POST['tanggal_awal'];
  $tanggal_akhir     = $_POST['tanggal_akhir'];
  $alasan            = $_POST['alasan'];

  // if(!$namaJabatan || !$idJabatan){
  //   $response['success'] = 0;
  //   $response['message'] = "Data kosong";

  //   echo json_encode($response);
  //   return false; 
  // } 

  $hasil  = $db->query(" UPDATE `ijin_cuti` SET `tanggal_awal`='$tanggal_awal',`tanggal_akhir`='$tanggal_akhir',`persetujuan`='1' WHERE id_ijin='$id_ijin' ");
  
  if($hasil){
    $response['success'] = 1;
    $response['message'] = "IJin berhasil diupdate";


    //
    $idUser = $_POST['id_user'];

    $dateAwal = strtotime($tanggal_awal);
    $dateAkhir = strtotime($tanggal_akhir);

    $secs = $dateAkhir - $dateAwal;// == <seconds between the two times>
    $intervalDay = $secs / 86400;

    $startDate=$tanggal_awal;

$rssql = "SELECT * FROM log_absen WHERE id_karyawan=$idUser ORDER BY date DESC LIMIT $intervalDay";
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

    // declare tanggal 
      $startDate = $tanggal_awal;

    // perualangan tanggal
      while(strtotime($tanggal_awal) <= strtotime($tanggal_akhir)){
        $item['date'] = $tanggal_awal;

          // pencocokan tanggal dengan data yg ada di database
          foreach($raw as $a){
            
            // jika di tgl tersebut ada data
            if($tanggal_awal == $a['date']){
                $nama_tabel     = 'log_absen';
                $hasil  = $db->query("UPDATE $nama_tabel SET keterangan = '$jenis_ijin'
                WHERE id_karyawan='$idUser' AND date='$tanggal_awal'");           
              break;
            } 
            // jika di tgl tersebut tidak ada data 
            else{
              
              $nama_tabel     = 'log_absen';
                $hasil  = $db->query("INSERT INTO $nama_tabel VALUES(NULL, '$idUser', '$tanggal_awal', '', '', '$jenis_ijin')");
                break;
            }
          
          }
        // masukan object ke var array response
        array_push($response, $item);

        $tanggal_awal = date("Y-m-d", strtotime("+1 days", strtotime($tanggal_awal)));
        

      }
    
  }
;?>
