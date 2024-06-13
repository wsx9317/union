import 'package:unionCDPP/modelVO/noticeFileItem.dart';

class NoticeItem {
  String? noticeNo;
  String? title;
  String? content;
  String? url;
  String? filePath;
  String? fileName;
  String? distributeYn;
  String? delYn;
  String? createDate;
  String? createId;
  String? updateDate;
  String? updateId;
  String? creator;
  String? s3FileUrl;
  String? iresponseCode;
  String? attachCnt;
  List<NoticeFileItem>? fileList;

  NoticeItem({
    this.noticeNo,
    this.title,
    this.content,
    this.url,
    this.filePath,
    this.fileName,
    this.distributeYn,
    this.delYn,
    this.createDate,
    this.createId,
    this.updateDate,
    this.updateId,
    this.creator,
    this.s3FileUrl,
    this.iresponseCode,
    this.attachCnt,
    this.fileList,
  });

  NoticeItem.fromJson(Map<String, dynamic> json)
      : noticeNo = json['noticeNo'] as String?,
        title = json['title'] as String?,
        content = json['content'] as String?,
        url = json['url'] as String?,
        filePath = json['filePath'] as String?,
        fileName = json['fileName'] as String?,
        distributeYn = json['distributeYn'] as String?,
        delYn = json['delYn'] as String?,
        createDate = json['createDate'] as String?,
        createId = json['createId'] as String?,
        updateDate = json['updateDate'] as String?,
        updateId = json['updateId'] as String?,
        creator = json['creator'] as String?,
        s3FileUrl = json['s3FileUrl'] as String?,
        iresponseCode = json['iresponseCode'] as String?,
        attachCnt = json['attachCnt'] as String?,
        fileList = (json['fileList'] as List?)?.map((dynamic e) => NoticeFileItem.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'noticeNo': noticeNo,
        'title': title,
        'content': content,
        'url': url,
        'filePath': filePath,
        'fileName': fileName,
        'distributeYn': distributeYn,
        'delYn': delYn,
        'createDate': createDate,
        'createId': createId,
        'updateDate': updateDate,
        'updateId': updateId,
        'creator': creator,
        's3FileUrl': s3FileUrl,
        'iresponseCode': iresponseCode,
        'attachCnt': attachCnt,
        'fileList': fileList,
      };

  @override
  String toString() {
    return 'NoticeItem(noticeNo: $noticeNo, title: $title, content: $content, url: $url, filePath: $filePath, fileName: $fileName,  distributeYn: $distributeYn, delYn: $delYn, createDate: $createDate, createId: $createId, updateDate: $updateDate, updateId: $updateId, creator: $creator, s3FileUrl: $s3FileUrl, iresponseCode: $iresponseCode, attachCnt: $attachCnt, fileList:$fileList)';
  }
}
