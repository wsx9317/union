class MyAlarmItem {
  String? userNo;
  String? dealLogNo;
  String? dealNo;
  String? status;
  String? title;
  String? etc;
  String? delYn;
  String? createDate;
  String? createId;
  String? updateDate;
  String? updateId;
  String? checkYn;

  MyAlarmItem({
    this.userNo,
    this.dealLogNo,
    this.dealNo,
    this.status,
    this.title,
    this.etc,
    this.delYn,
    this.createDate,
    this.createId,
    this.updateDate,
    this.updateId,
    this.checkYn,
  });

  MyAlarmItem.fromJson(Map<String, dynamic> json)
      : userNo = json['userNo'] as String?,
        dealLogNo = json['dealLogNo'] as String?,
        dealNo = json['dealNo'] as String?,
        status = json['status'] as String?,
        title = json['title'] as String?,
        etc = json['etc'] as String?,
        delYn = json['delYn'] as String?,
        createDate = json['createDate'] as String?,
        createId = json['createId'] as String?,
        updateDate = json['updateDate'] as String?,
        updateId = json['updateId'] as String?,
        checkYn = json['checkYn'] as String?;

  Map<String, dynamic> toJson() => {
        'userNo': userNo,
        'dealLogNo': dealLogNo,
        'dealNo': dealNo,
        'status': status,
        'title': title,
        'etc': etc,
        'delYn': delYn,
        'createDate': createDate,
        'createId': createId,
        'updateDate': updateDate,
        'updateId': updateId,
        'checkYn': checkYn,
      };

  @override
  String toString() {
    return 'MyAlarmItem(userNo: $userNo, dealLogNo: $dealLogNo, dealNo: $dealNo, status: $status, title: $title, etc: $etc, delYn: $delYn, createDate: $createDate, createId: $createId, updateDate: $updateDate, updateId: $updateId, checkYn: $checkYn)';
  }
}
