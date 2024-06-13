class DominantItem {
  String? dealDomiNo;
  String? dealNo;
  String? userNo;
  String? status;

  DominantItem({
    this.dealDomiNo,
    this.dealNo,
    this.userNo,
    this.status,
  });

  DominantItem.fromJson(Map<String, dynamic> json)
      : dealDomiNo = json['dealDomiNo'] as String?,
        dealNo = json['dealNo'] as String?,
        userNo = json['userNo'] as String?,
        status = json['status'] as String?;

  Map<String, dynamic> toJson() => {
        'dealDomiNo': dealDomiNo,
        'dealNo': dealNo,
        'userNo': userNo,
        'status': status,
      };

  @override
  String toString() {
    return 'DominantItem(dealDomiNo:$dealDomiNo, dealNo:$dealNo, userNo:$userNo, status:$status)';
  }
}
