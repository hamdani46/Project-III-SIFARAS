class HitungModel {
  String? total, ditangani;

  HitungModel(this.total, this.ditangani);

  HitungModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    ditangani = json['ditangani'];
  }
}
