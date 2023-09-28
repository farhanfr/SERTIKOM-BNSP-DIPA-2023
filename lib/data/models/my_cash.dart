class MyCash {
  int? id;
  String? userId;
  String? nominal;
  String? keterangan;
  String? tanggalProses;
  String? jenisProses;

  MyCash({
    this.id,
    this.userId,
    this.nominal,
    this.keterangan,
    this.tanggalProses,
    this.jenisProses,
  });

  factory MyCash.fromJson(Map<String, dynamic> json) => MyCash(
        id: json["id"],
        userId: json["user_id"],
        nominal: json["nominal"],
        keterangan: json["keterangan"],
        tanggalProses: json["tanggal_proses"],
        jenisProses: json["jenis_proses"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nominal": nominal,
        "keterangan": keterangan,
        "tanggal_proses": tanggalProses,
        "jenis_proses": jenisProses
      };
}
