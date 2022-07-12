class DaftarBerobatModel {
  String? idDaftar;
  String? tanggal;
  String? idPasien;
  String? idPoli;
  String? idDokter;
  String? noAntrian;
  String? keluhan;
  String? diagnosa;
  String? obat;
  String? pemeriksaan;
  String? tindakan;
  String? status;
  String? namaDokter;
  String? namaPasien;
  String? namaPoli;

  DaftarBerobatModel(
      this.idDaftar,
      this.tanggal,
      this.idPasien,
      this.idPoli,
      this.idDokter,
      this.noAntrian,
      this.keluhan,
      this.diagnosa,
      this.obat,
      this.pemeriksaan,
      this.tindakan,
      this.status,
      this.namaDokter,
      this.namaPasien,
      this.namaPoli);

  DaftarBerobatModel.fromJson(Map<String, dynamic> json) {
    idDaftar = json["id_daftar"];
    tanggal = json["tanggal"];
    idPasien = json["id_pasien"];
    idPoli = json["id_poli"];
    idDokter = json["id_dokter"];
    noAntrian = json["no_antrian"];
    keluhan = json["keluhan"];
    diagnosa = json["diagnosa"];
    obat = json["obat"];
    pemeriksaan = json["pemeriksaan"];
    tindakan = json["tindakan"];
    status = json["status"];
    namaDokter = json['nama_dokter'];
    namaPasien = json['nama_pasien'];
    namaPoli = json['nama_poli'];
  }
}
