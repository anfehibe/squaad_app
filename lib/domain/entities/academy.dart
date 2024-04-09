import 'dart:convert';

class Academy {
  int id;
  int userId;
  String name;
  int feePercentage;
  String fee;
  String email;
  String mobile;
  String website;
  String address;
  String city;
  int stateId;
  String zipcode;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String mobileMask;
  String imageUrl;

  Academy({
    required this.id,
    required this.userId,
    required this.name,
    required this.feePercentage,
    required this.fee,
    required this.email,
    required this.mobile,
    required this.website,
    required this.address,
    required this.city,
    required this.stateId,
    required this.zipcode,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.mobileMask,
    required this.imageUrl,
  });

  factory Academy.fromRawJson(String str) => Academy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Academy.fromJson(Map<String, dynamic> json) => Academy(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        feePercentage: json["fee_percentage"],
        fee: json["fee"],
        email: json["email"],
        mobile: json["mobile"],
        website: json["website"],
        address: json["address"],
        city: json["city"],
        stateId: json["state_id"],
        zipcode: json["zipcode"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        mobileMask: json["mobile_mask"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "fee_percentage": feePercentage,
        "fee": fee,
        "email": email,
        "mobile": mobile,
        "website": website,
        "address": address,
        "city": city,
        "state_id": stateId,
        "zipcode": zipcode,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "mobile_mask": mobileMask,
        "image_url": imageUrl,
      };
}
