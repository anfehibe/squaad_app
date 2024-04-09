import 'dart:convert';

class Media {
  int id;
  int boardId;
  int type;
  String file;
  DateTime createdAt;
  DateTime updatedAt;
  String fileUrl;

  Media({
    required this.id,
    required this.boardId,
    required this.type,
    required this.file,
    required this.createdAt,
    required this.updatedAt,
    required this.fileUrl,
  });

  factory Media.fromRawJson(String str) => Media.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        boardId: json["board_id"],
        type: json["type"],
        file: json["file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fileUrl: json["file_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "board_id": boardId,
        "type": type,
        "file": file,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "file_url": fileUrl,
      };
}
