class NoticeFileItem {
  String? fileName;
  String? s3Url;
  String? filePath;

  NoticeFileItem({
    this.fileName,
    this.s3Url,
    this.filePath,
  });

  NoticeFileItem.fromJson(Map<String, dynamic> json)
      : fileName = json['fileName'] as String?,
        s3Url = json['s3Url'] as String?,
        filePath = json['filePath'] as String?;

  Map<String, dynamic> toJson() => {
        'fileName': fileName,
        's3Url': s3Url,
        'filePath': filePath,
      };

  @override
  String toString() {
    return 'NoticeFileItem(fileName: $fileName, s3Url: $s3Url, filePath: $filePath)';
  }
}
