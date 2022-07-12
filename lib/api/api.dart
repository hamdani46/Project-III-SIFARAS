class BaseUrl {
  static String url = "http://192.168.100.39/api-sifaras/";
  static String paths = "http://192.168.33.34/api-sifaras/upload/";

  // LOGIN
  static String urlLogin = url + "api/login.php";

  // // PETUGAS
  static String urlListPetugas = url + "api/petugas/list.php";
  static String urlTambahPetugas = url + "api/petugas/add.php";
  static String urlUbahPetugas = url + "api/petugas/edit.php";
  static String urlHapusPetugas = url + "api/petugas/delete.php";

  // // DOKTER
  static String urlListDokter = url + "api/dokter/list.php";
  static String urlListDokterdaftar = url + "api/dokter/list_daftar.php";
  static String urlTambahDokter = url + "api/dokter/add.php";
  static String urlUbahDokter = url + "api/dokter/edit.php";
  static String urlHapusDokter = url + "api/dokter/delete.php";

  // // JABATAN
  static String urlListJabatan = url + "api/jabatan/list.php";
  static String urlTambahJabatan = url + "api/jabatan/add.php";
  static String urlUbahJabatan = url + "api/jabatan/edit.php";
  static String urlHapusJabatan = url + "api/jabatan/delete.php";

  // ADD LOG DAFTAR
  // static String urlLogAbsen = url + "api/log_absen.php";
  // static String urlLogAbsenPulang = url + "api/log_absen_pulang.php";
  static String urlListAbsen = url + "api/list_absen.php";

  //ADD BEROBAT
  static String urlListDaftarBerobat = url + "api/daftar_berobat/list.php";
  static String urlTambahDaftarBerobat = url + "api/daftar_berobat/add.php";
  static String urlUbahDaftarBerobat = url + "api/daftar_berobat/edit.php";
  static String urlHapusDaftarBerobat = url + "api/daftar_berobat/delete.php";
  static String urlListAntrianDokter =
      url + "api/daftar_berobat/list_antrian_dokter.php";
  static String urlUpdateDaftarBerobat = url + "api/daftar_berobat/update.php";
  static String urlHitungDaftar = url + "api/daftar_berobat/hitung.php";

  //PERSETUJUAN
  static String urlListPersetujuan = url + "api/persetujuan/list.php";
  static String urlSetujuPersetujuan = url + "api/persetujuan/setuju.php";
  static String urlTolakPersetujuan = url + "api/persetujuan/tolak.php";

  //DAFTAR CUSTOMER
  static String urlTambahCustomer = url + "api/customer/add.php";
  static String urlListCustomer = url + "api/customer/list.php";
  static String urlUbahCustomer = url + "api/customer/edit.php";
  static String urlHapusCustomer = url + "api/customer/delete.php";

  //POLI
  static String urlListPoli = url + "api/poli/list.php";
  static String urlTambahPoli = url + "api/poli/add.php";
  static String urlUbahPoli = url + "api/poli/edit.php";
  static String urlHapusPoli = url + "api/poli/delete.php";
}
