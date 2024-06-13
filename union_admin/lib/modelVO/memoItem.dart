class MemoItem {
  String? dealMemoNo; //메모 고유번호
  String? dealNo; //딜 고유번호
  String? memo; //메모내용
  String? fileName; //파일명
  String? createDate; //등록일시
  String? s3FileUrl; //S3 파일 Url
  String? creator; //작성자

  MemoItem({
    this.dealMemoNo,
    this.dealNo,
    this.memo,
    this.fileName,
    this.createDate,
    this.s3FileUrl,
    this.creator,
  });

  MemoItem.fromJson(Map<String, dynamic> json)
      : dealMemoNo = json['dealMemoNo'] as String?,
        dealNo = json['dealNo'] as String?,
        memo = json['memo'] as String?,
        fileName = json['fileName'] as String?,
        createDate = json['createDate'] as String?,
        s3FileUrl = json['s3FileUrl'] as String?,
        creator = json['creator'] as String?;

  Map<String, dynamic> toJson() => {
        'dealMemoNo': dealMemoNo,
        'dealNo': dealNo,
        'memo': memo,
        'fileName': fileName,
        'createDate': createDate,
        's3FileUrl': s3FileUrl,
        'creator': creator,
      };

  @override
  String toString() {
    return 'MemoItem(dealMemoNo: $dealMemoNo, dealNo: $dealNo, memo: $memo, fileName: $fileName, createDate: $createDate, s3FileUrl: $s3FileUrl, creator: $creator)';
  }
}
