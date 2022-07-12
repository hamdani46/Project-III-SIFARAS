class IjinCutiModel {
  String? idUser;
  String? idIjin;
  String? jenisIjin;
  String? tanggalAwal;
  String? tanggalAkhir;
  String? alasan;
  String? persetujuan;
  String? nama;

  IjinCutiModel(this.idUser, this.idIjin, this.jenisIjin, this.tanggalAwal,
      this.tanggalAkhir, this.alasan, this.persetujuan, this.nama);

  IjinCutiModel.fromJson(Map<String, dynamic> json) {
    idUser = json["id_user"];
    idIjin = json["id_ijin"];
    jenisIjin = json["jenis_ijin"];
    tanggalAwal = json["tanggal_awal"];
    tanggalAkhir = json["tanggal_akhir"];
    alasan = json["alasan"];
    persetujuan = json["persetujuan"];
    nama = json["nama"];
  }
}
