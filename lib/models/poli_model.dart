class PoliModel {
  String? idPoli, namaPoli, logDatetime;

  PoliModel(this.idPoli, this.namaPoli, this.logDatetime);

  PoliModel.fromJson(Map<String, dynamic> json) {
    idPoli = json['id_poli'];
    namaPoli = json['nama_poli'];
    logDatetime = json['log_datetime'];
  }
}
