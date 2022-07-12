import 'package:intl/intl.dart';

class LogAbsenModel {
  String? idAbsen;
  String? date;
  String? jamMasuk;
  String? jamPulang;
  String? keterangan;

  LogAbsenModel(
    this.idAbsen,
    this.date,
    this.jamMasuk,
    this.jamPulang,
    this.keterangan,
  );

  LogAbsenModel.fromJson(Map<String, dynamic> json) {
    idAbsen = json["id_absen"];
    date = json["date"];
    jamMasuk = json["jam_masuk"];
    jamPulang = json["jam_pulang"];
    keterangan = json["Keterangan"];
  }
}
