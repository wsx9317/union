class DealDomiItem {
  String? dealDomiNo;
  String? dealNo;
  String? userName;
  String? startDate;
  String? endDate;
  String? title;
  String? office;
  String? asking;
  String? address;
  String? lotArea;
  String? totalFloorArea;
  String? type;
  List? domiNoList;

  DealDomiItem({
    this.dealDomiNo,
    this.dealNo,
    this.userName,
    this.startDate,
    this.endDate,
    this.title,
    this.office,
    this.asking,
    this.address,
    this.lotArea,
    this.totalFloorArea,
    this.type,
    this.domiNoList,
  });

  factory DealDomiItem.fromJson(Map<String, dynamic> json) {
    return DealDomiItem(
      dealDomiNo: json['dealDomiNo'] as String?,
      dealNo: json['dealNo'] as String?,
      userName: json['userName'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      title: json['title'] as String?,
      office: json['office'] as String?,
      asking: json['asking'] as String?,
      address: json['address'] as String?,
      lotArea: json['lotArea'] as String?,
      totalFloorArea: json['totalFloorArea'] as String?,
      type: json['type'] as String?,
      domiNoList: json['domiNoList'] as List?,
    );
  }

  Map<String, dynamic> toJson() => {
        'dealDomiNo': dealDomiNo,
        'dealNo': dealNo,
        'userName': userName,
        'startDate': startDate,
        'endDate': endDate,
        'title': title,
        'office': office,
        'asking': asking,
        'address': address,
        'lotArea': lotArea,
        'totalFloorArea': totalFloorArea,
        'type': type,
        'domiNoList': domiNoList,
      };

  @override
  String toString() {
    return 'DealDomiItem(dealDomiNo: $dealDomiNo, dealNo: $dealNo, userName: $userName, startDate: $startDate, endDate: $endDate, title: $title, office: $office, asking: $asking, address: $address, lotArea: $lotArea, totalFloorArea: $totalFloorArea, type: $type, domiNoList: $domiNoList)';
  }
}
