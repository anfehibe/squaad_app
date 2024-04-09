import 'dart:convert';

import 'academy.dart';
import 'media.dart';

class License {
  int id;
  int academyId;
  String license;
  String name;
  String banner;
  String qrInfo;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String bannerUrl;
  String qrInfoUrl;
  Academy academy;
  List<Media> media;

  License({
    required this.id,
    required this.academyId,
    required this.license,
    required this.name,
    required this.banner,
    required this.qrInfo,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.bannerUrl,
    required this.qrInfoUrl,
    required this.academy,
    required this.media,
  });

  factory License.fromRawJson(String str) => License.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory License.fromJson(Map<String, dynamic> json) => License(
        id: json["id"],
        academyId: json["academy_id"],
        license: json["license"],
        name: json["name"],
        banner: json["banner"],
        qrInfo: json["qr_info"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        bannerUrl: json["banner_url"],
        qrInfoUrl: json["qr_info_url"],
        academy: Academy.fromJson(json["academy"]),
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "academy_id": academyId,
        "license": license,
        "name": name,
        "banner": banner,
        "qr_info": qrInfo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "banner_url": bannerUrl,
        "qr_info_url": qrInfoUrl,
        "academy": academy.toJson(),
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
      };
}
