class CertItem {
  String? dealNo;
  String? type;
  String? category;
  String? startDate;
  String? endDate;
  String? createDate;
  String? userName;
  String? office;
  String? address;
  String? addressDtl;

  CertItem({
    this.dealNo,
    this.type,
    this.category,
    this.startDate,
    this.endDate,
    this.createDate,
    this.userName,
    this.office,
    this.address,
    this.addressDtl,
  });

  CertItem.fromJson(Map<String, dynamic> json)
      : dealNo = json['dealNo'] as String?,
        type = json['type'] as String?,
        category = json['category'] as String?,
        startDate = json['startDate'] as String?,
        endDate = json['endDate'] as String?,
        createDate = json['deacreateDatelNo'] as String?,
        userName = json['userName'] as String?,
        address = json['address'] as String?,
        addressDtl = json['addressDtl'] as String?;

  Map<String, dynamic> toJson() => {
        'dealNo': dealNo,
        'type': type,
        'category': category,
        'startDate': startDate,
        'endDate': endDate,
        'createDate': createDate,
        'userName': userName,
        'address': address,
        'addressDtl': addressDtl,
      };

  @override
  String toString() {
    return 'CertItem(dealNo: $dealNo, type: $type, category: $category, startDate: $startDate, endDate: $endDate, createDate: $createDate, userName: $userName, office: $office, address: $address, addressDtl: $addressDtl)';
  }
}
