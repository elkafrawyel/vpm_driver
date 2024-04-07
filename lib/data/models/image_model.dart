class ImageModel {
  ImageModel({
    this.id,
    this.filePath,
    this.originalName,
  });

  ImageModel.fromJson(dynamic json) {
    id = json['id'];
    filePath = json['file_path'];
    originalName = json['original_name'];
  }

  String? id;
  String? filePath;
  String? originalName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['file_path'] = filePath;
    map['original_name'] = originalName;
    return map;
  }
}
