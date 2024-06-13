class FaqItem {
  int? page;
  int? rowSize;
  int? faqNo;
  String? section;
  String? question;
  String? answer;
  String? answerDesc;
  String? url;
  String? filePath;
  String? fileName;
  String? distributeYn;
  String? delYn;
  String? createDate;
  String? createId;
  String? updateDate;
  String? updateId;
  String? s3FileUrl;
  String? iresponseCode;

  FaqItem({
    this.page,
    this.rowSize,
    this.faqNo,
    this.section,
    this.question,
    this.answer,
    this.answerDesc,
    this.url,
    this.filePath,
    this.fileName,
    this.distributeYn,
    this.delYn,
    this.createDate,
    this.createId,
    this.updateDate,
    this.updateId,
    this.s3FileUrl,
    this.iresponseCode,
  });

  FaqItem.fromJson(Map<String, dynamic> json)
      : page = json['page'] as int?,
        rowSize = json['rowSize'] as int?,
        faqNo = json['faqNo'] as int?,
        section = json['section'] as String?,
        question = json['question'] as String?,
        answer = json['answer'] as String?,
        answerDesc = json['answerDesc'] as String?,
        url = json['url'] as String?,
        filePath = json['filePath'] as String?,
        fileName = json['fileName'] as String?,
        distributeYn = json['distributeYn'] as String?,
        delYn = json['delYn'] as String?,
        createDate = json['createDate'] as String?,
        createId = json['createId'] as String?,
        updateDate = json['updateDate'] as String?,
        updateId = json['updateId'] as String?,
        s3FileUrl = json['s3FileUrl'] as String?,
        iresponseCode = json['iresponseCode'] as String?;

  Map<String, dynamic> toJson() => {
        'page': page,
        'rowSize': rowSize,
        'faqNo': faqNo,
        'section': section,
        'question': question,
        'answer': answer,
        'answerDesc': answerDesc,
        'url': url,
        'filePath': filePath,
        'fileName': fileName,
        'distributeYn': distributeYn,
        'delYn': delYn,
        'createDate': createDate,
        'createId': createId,
        'updateDate': updateDate,
        'updateId': updateId,
        's3FileUrl': s3FileUrl,
        'iresponseCode': iresponseCode,
      };

  @override
  String toString() {
    return 'FaqItem(page:$page, rowSize:$rowSize, faqNo:$faqNo, section:$section, question:$question, answer:$answer, answerDesc:$answerDesc, url:$url, filePath:$filePath, fileName:$fileName, distributeYn:$distributeYn, delYn:$delYn, createDate:$createDate, createId:$createId, updateDate:$updateDate, updateId:$updateId, s3FileUrl:$s3FileUrl, iresponseCode:$iresponseCode)';
  }
}
