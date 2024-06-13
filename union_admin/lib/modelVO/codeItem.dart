class CodeItem {
  String? cd; //코드
  String? cdName; //이름

  CodeItem({
    this.cd,
    this.cdName,
  });

  CodeItem.fromJson(Map<String, dynamic> json)
      : cd = json['cd'] as String?,
        cdName = json['cdName'] as String?;

  Map<String, dynamic> toJson() => {
        'cd': cd,
        'cdName': cdName,
      };

  @override
  String toString() {
    return 'CodeItem(cd: $cd, cdName: $cdName)';
  }
}
