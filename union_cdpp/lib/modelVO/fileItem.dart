import 'dart:convert';

class FileItem {
  String? dealFileNo;
  String? userNo;
  String? dealNo;
  String? fileOrder;
  String? filePath;
  String? fileName;
  String? fileDoc;
  String? s3FileUrl;
  String? fileType;
  String? delYn;
  String? createDate;
  String? createId;
  String? updateDate;
  String? updateId;
  String? tempYn;
  FileItem({
    this.dealFileNo,
    this.userNo,
    this.dealNo,
    this.fileOrder,
    this.filePath,
    this.fileName,
    this.fileDoc,
    this.s3FileUrl,
    this.fileType,
    this.delYn,
    this.createDate,
    this.createId,
    this.updateDate,
    this.updateId,
    this.tempYn,
  });

  FileItem.fromJson(Map<String, dynamic> json)
      : dealFileNo = json['dealFileNo'] as String?,
        userNo = json['userNo'] as String?,
        dealNo = json['dealNo'] as String?,
        fileOrder = json['fileOrder'] as String?,
        filePath = json['filePath'] as String?,
        fileName = json['fileName'] as String?,
        fileDoc = json['fileDoc'] as String?,
        s3FileUrl = json['s3FileUrl'] as String?,
        fileType = json['fileType'] as String?,
        delYn = json['delYn'] as String?,
        createDate = json['createDate'] as String?,
        createId = json['createId'] as String?,
        updateDate = json['uupdateDateserNo'] as String?,
        updateId = json['updateId'] as String?,
        tempYn = json['tempYn'] as String?;

  Map<String, dynamic> toJson() => {
        'dealFileNo': dealFileNo,
        'userNo': userNo,
        'dealNo': dealNo,
        'fileOrder': fileOrder,
        'filePath': filePath,
        'fileName': fileName,
        'fileDoc': fileDoc,
        's3FileUrl': s3FileUrl,
        'fileType': fileType,
        'delYn': delYn,
        'createDate': createDate,
        'createId': createId,
        'updateDate': updateDate,
        'updateId': updateId,
        'tempYn': tempYn,
      };

  @override
  String toString() {
    return 'FileItem(dealFileNo: $dealFileNo, userNo: $userNo, dealNo: $dealNo, fileOrder: $fileOrder, filePath: $filePath, fileName: $fileName, fileDoc: $fileDoc, s3FileUrl:$s3FileUrl, fileType: $fileType, delYn: $delYn, createDate: $createDate, createId: $createId, updateDate: $updateDate, updateId: $updateId, tempYn: $tempYn)';
  }
}
