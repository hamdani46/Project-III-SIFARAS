class PetugasModel {
  String? idUser;
  String? namaLengkap;
  String? jenisKelamin;
  String? tanggalLahir;
  String? namaJabatan;
  String? tanggalGabung;
  String? logDatetime;
  String? idJabatan;

  PetugasModel(
    this.idUser,
    this.namaLengkap,
    this.jenisKelamin,
    this.tanggalLahir,
    this.namaJabatan,
    this.tanggalGabung,
    this.logDatetime,
    this.idJabatan,
  );

  PetugasModel.fromJson(Map<String, dynamic> json) {
    idUser = json["id_user"];
    namaLengkap = json["nama_lengkap"];
    jenisKelamin = json["jenis_kelamin"];
    tanggalLahir = json["tanggal_lahir"];
    namaJabatan = json["nama_jabatan"];
    tanggalGabung = json["tanggal_gabung"];
    logDatetime = json["log_datetime"];
    idJabatan = json['id_jabatan'];
  }
}
