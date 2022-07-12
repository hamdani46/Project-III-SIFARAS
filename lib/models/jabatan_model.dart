class JabatanModel {
  String? idJabatan, namaJabatan, logDatetime;

  JabatanModel(this.idJabatan, this.namaJabatan, this.logDatetime);

  JabatanModel.fromJson(Map<String, dynamic> json) {
    idJabatan = json['id_jabatan'];
    namaJabatan = json['nama_jabatan'];
    logDatetime = json['log_datetime'];
  }
}
