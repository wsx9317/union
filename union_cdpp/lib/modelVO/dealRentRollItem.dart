class DealRentRollItem {
  String? dealRentNo;
  String? dealNo;
  String? floor;
  String? sectors; //업종
  String? area;
  String? deposit; //보증금
  String? rent; //임대료
  String? etc;

  DealRentRollItem({
    this.dealRentNo,
    this.dealNo,
    this.floor,
    this.sectors,
    this.area,
    this.deposit,
    this.rent,
    this.etc,
  });

  DealRentRollItem.fromJson(Map<String, dynamic> json)
      : dealRentNo = json['dealRentNo'] as String?,
        dealNo = json['dealNo'] as String?,
        floor = json['floor'] as String?,
        sectors = json['sectors'] as String?,
        area = json['area'] as String?,
        deposit = json['deposit'] as String?,
        rent = json['rent'] as String?,
        etc = json['etc'] as String?;

  Map<String, dynamic> toJson() => {
        'dealRentNo': dealRentNo,
        'dealNo': dealNo,
        'floor': floor,
        'sectors': sectors,
        'area': area,
        'deposit': deposit,
        'rent': rent,
        'etc': etc,
      };

  @override
  String toString() {
    return '{"dealRentNo": "$dealRentNo", "dealNo": "$dealNo", "floor": "$floor", "sectors": "$sectors", "area": "$area", "deposit": "$deposit", "rent": "$rent", "etc": "$etc"}';
  }
}
