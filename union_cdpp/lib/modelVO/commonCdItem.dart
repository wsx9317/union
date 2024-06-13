class CommonCdItem {
  String? cd;
  String? cdName;

  CommonCdItem({
    this.cd,
    this.cdName,
  });

  CommonCdItem.fromJson(Map<String, dynamic> json)
      : cd = json['cd'] as String?,
        cdName = json['cdName'] as String?;

  Map<String, dynamic> toJson() => {
        'cd': cd,
        'cdName': cdName,
      };

  @override
  String toString() {
    return 'CommonCdItem(CommonCdItem(cd: $cd, cdName: $cdName)';
  }
}
