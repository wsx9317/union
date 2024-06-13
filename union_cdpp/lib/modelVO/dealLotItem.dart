class DealLotItem {
  String? dealLotNo;
  String? dealNo;
  String? address; //필지주소
  String? lotArea; //대지면적(제곱미터)
  String? lotAreaPy; //대지면적(평)
  String? areaPurpose;
  String? officialLandPrice; //공시지가
  String? totalLandPrice; //공시지가합계
  String? asking; //매도가격
  String? pnu; //필지고유번호

  DealLotItem({
    this.dealLotNo,
    this.dealNo,
    this.pnu,
    this.address,
    this.lotArea,
    this.lotAreaPy,
    this.areaPurpose,
    this.officialLandPrice,
    this.totalLandPrice,
    this.asking,
  });

  DealLotItem.fromJson(Map<String, dynamic> json)
      : dealLotNo = json['dealLotNo'] as String?,
        dealNo = json['dealNo'] as String?,
        pnu = json['pnu'] as String?,
        address = json['address'] as String?,
        lotArea = json['lotArea'] as String?,
        lotAreaPy = json['lotAreaPy'] as String?,
        areaPurpose = json['areaPurpose'] as String?,
        officialLandPrice = json['officialLandPrice'] as String?,
        totalLandPrice = json['totalLandPrice'] as String?,
        asking = json['asking'] as String?;

  Map<String, dynamic> toJson() => {
        'dealLotNo': dealLotNo,
        'dealNo': dealNo,
        'pnu': pnu,
        'address': address,
        'lotArea': lotArea,
        'lotAreaPy': lotAreaPy,
        'areaPurpose': areaPurpose,
        'officialLandPrice': officialLandPrice,
        'totalLandPrice': totalLandPrice,
        'asking': asking,
      };

  @override
  String toString() {
    return '{"dealLotNo": "$dealLotNo", "dealNo":"$dealNo", "pnu": "$pnu", "address":"$address", "lotArea":"$lotArea", "lotAreaPy":"$lotAreaPy", "areaPurpose":"$areaPurpose", "officialLandPrice": "$officialLandPrice", "totalLandPrice": "$totalLandPrice", "asking":"$asking"}';
  }
}
