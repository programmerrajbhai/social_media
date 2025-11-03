class UploadModel {
  final String title;
  final String imageBase64;

  UploadModel({required this.title, required this.imageBase64});

  Map<String, dynamic> toJson() => {
    'title': title,
    'image': imageBase64,
  };
}
