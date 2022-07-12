class CustomerModel {
  String? idUser;
  String? namaLengkap;
  String? jenisKelamin;
  String? tanggalLahir;

  CustomerModel(
    this.idUser,
    this.namaLengkap,
    this.jenisKelamin,
    this.tanggalLahir,
  );

  CustomerModel.fromJson(Map<String, dynamic> json) {
    idUser = json["id_user"];
    namaLengkap = json["nama_lengkap"];
    jenisKelamin = json["jenis_kelamin"];
    tanggalLahir = json["tanggal_lahir"];
  }
}
