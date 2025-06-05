import 'dart:convert';

class IndukRequestModel {
    final int? adminId;
    final String? noRing;
    final DateTime? tanggalLahir;
    final String? jenisKelamin;
    final String? jenisKenari;
    final dynamic keterangan;
    final String? gambarInduk;

    IndukRequestModel({
        this.adminId,
        this.noRing,
        this.tanggalLahir,
        this.jenisKelamin,
        this.jenisKenari,
        this.keterangan,
        this.gambarInduk,
    });

    String toRawJson() => json.encode(toMap());
    factory IndukRequestModel.fromJson(String str) => IndukRequestModel.fromMap(json.decode(str));

    Map<String, dynamic> toJson() => toMap();
    // String toJson() => json.encode(toMap());

    factory IndukRequestModel.fromMap(Map<String, dynamic> json) => IndukRequestModel(
        adminId: json["admin_id"],
        noRing: json["no_ring"],
        tanggalLahir: json["tanggal_lahir"] == null ? null : DateTime.parse(json["tanggal_lahir"]),
        jenisKelamin: json["jenis_kelamin"],
        jenisKenari: json["jenis_kenari"],
        keterangan: json["keterangan"],
        gambarInduk: json["gambar_induk"],
    );

    Map<String, dynamic> toMap() => {
        "admin_id": adminId,
        "no_ring": noRing,
        "tanggal_lahir": "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
        "jenis_kelamin": jenisKelamin,
        "jenis_kenari": jenisKenari,
        "keterangan": keterangan,
        "gambar_induk": gambarInduk,
    };
}
