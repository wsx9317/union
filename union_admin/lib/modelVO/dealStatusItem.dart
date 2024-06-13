class DealStatusItem {
  String? dealNo;
  String? title;
  String? etc;
  String? createDate;
  String? creator;

  DealStatusItem({
    this.dealNo,
    this.title,
    this.etc,
    this.createDate,
    this.creator,
  });

  DealStatusItem.fromJson(Map<String, dynamic> json)
      : dealNo = json['dealNo'] as String?,
        title = json['title'] as String?,
        etc = json['etc'] as String?,
        createDate = json['createDate'] as String?,
        creator = json['creator'] as String?;

  Map<String, dynamic> toJson() => {
        'dealNo': dealNo,
        'title': title,
        'etc': etc,
        'createDate': createDate,
        'creator': creator,
      };

  @override
  String toString() {
    return 'DealStatusItem(dealNo:$dealNo, title:$title, etc:$etc, createDate:$createDate, creator:$creator)';
  }
}
