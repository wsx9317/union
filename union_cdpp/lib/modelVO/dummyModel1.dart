class DummyModel1 {
  int? myPageSeq;
  String? myPageType;
  String? myPageTitle;
  String? myPageStatusCheckYN;
  String? myPageDateTime;
  double? page;
  String? useYN;

  DummyModel1({
    this.myPageSeq,
    this.myPageType,
    this.myPageTitle,
    this.myPageStatusCheckYN,
    this.myPageDateTime,
    this.page,
    this.useYN,
  });

  @override
  String toString() {
    return 'DummyModel1(myPageSeq:$myPageSeq, myPageType:$myPageType, myPageTitle:$myPageTitle, myPageStatusCheckYN:$myPageStatusCheckYN, myPageDateTime:$myPageDateTime, page:$page, useYN:$useYN)';
  }

  factory DummyModel1.fromJson(Map<String, dynamic> json) {
    return DummyModel1(
      myPageSeq: json['myPageSeq'] as int?,
      myPageType: json['myPageType'] as String?,
      myPageTitle: json['myPageTitle'] as String?,
      myPageStatusCheckYN: json['myPageStatusCheckYN'] as String?,
      myPageDateTime: json['myPageDateTime'] as String?,
      page: json['page'] as double?,
      useYN: json['useYN'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'myPageSeq': myPageSeq,
        'myPageType': myPageType,
        'myPageTitle': myPageTitle,
        'myPageStatusCheckYN': myPageStatusCheckYN,
        'myPageDateTime': myPageDateTime,
        'page': page,
        'useYN': useYN,
      };
}
