class UploadRxModel {
  final List<UploadRxData> files;

  UploadRxModel({
    required this.files,
  });

  factory UploadRxModel.fromJson(Map<String, dynamic> json) => UploadRxModel(
        files: List<UploadRxData>.from(
          json["files"].map(
            (x) => UploadRxData.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
      };
}

class UploadRxData {
  final String fileName;
  final String fileId;
  final String link;
  final String status;

  UploadRxData({
    required this.fileName,
    required this.fileId,
    required this.link,
    required this.status,
  });

  const UploadRxData.reset()
      : fileId = "",
        fileName = "",
        link = "",
        status = "";

  factory UploadRxData.fromJson(Map<String, dynamic> json) => UploadRxData(
        fileName: json["fileName"],
        fileId: json["fileId"],
        link: json["link"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "fileId": fileId,
        "link": link,
        "status": status,
      };
}
