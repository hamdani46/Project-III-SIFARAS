class DokterModel {
  String? idUser;
  String? namaLengkap;
  String? jenisKelamin;
  String? tanggalLahir;
  String? namaJabatan;
  String? tanggalGabung;
  String? logDatetime;
  String? idJabatan;
  String? idPoli;

  DokterModel(
      this.idUser,
      this.namaLengkap,
      this.jenisKelamin,
      this.tanggalLahir,
      this.namaJabatan,
      this.tanggalGabung,
      this.logDatetime,
      this.idJabatan,
      this.idPoli);

  DokterModel.fromJson(Map<String, dynamic> json) {
    idUser = json["id_user"];
    namaLengkap = json["nama_lengkap"];
    jenisKelamin = json["jenis_kelamin"];
    tanggalLahir = json["tanggal_lahir"];
    namaJabatan = json["nama_jabatan"];
    tanggalGabung = json["tanggal_gabung"];
    logDatetime = json["log_datetime"];
    idJabatan = json['id_jabatan'];
    idPoli = json['id_poli'];
  }
}
