class DealLandItem {
  String? region1;
  String? region2;
  String? region3;
  String? bunji;
  String? jibunAddress;
  String? lotArea;
  String? lotAreaPy;
  String? areaPurpose;
  String? officialLandPrice;
  String? totalLandPrice;
  String? address;
  String? pnu;
  String? lineName;
  String? stationName;
  String? distance;

  DealLandItem({
    this.region1,
    this.region2,
    this.region3,
    this.bunji,
    this.jibunAddress,
    this.lotArea,
    this.lotAreaPy,
    this.areaPurpose,
    this.officialLandPrice,
    this.totalLandPrice,
    this.address,
    this.pnu,
    this.lineName,
    this.stationName,
    this.distance,
  });

  DealLandItem.fromJson(Map<String, dynamic> json)
      : region1 = json['region1'] as String?,
        region2 = json['region2'] as String?,
        region3 = json['region3'] as String?,
        bunji = json['bunji'] as String?,
        jibunAddress = json['jibunAddress'] as String?,
        lotArea = json['lotArea'] as String?,
        lotAreaPy = json['lotAreaPy'] as String?,
        areaPurpose = json['areaPurpose'] as String?,
        officialLandPrice = json['officialLandPrice'] as String?,
        totalLandPrice = json['totalLandPrice'] as String?,
        address = json['address'] as String?,
        pnu = json['pnu'] as String?,
        lineName = json['lineName'] as String?,
        stationName = json['stationName'] as String?,
        distance = json['distance'] as String?;

  Map<String, dynamic> toJson() => {
        'region1': region1,
        'region2': region2,
        'region3': region3,
        'bunji': bunji,
        'jibunAddress': jibunAddress,
        'lotArea': lotArea,
        'lotAreaPy': lotAreaPy,
        'areaPurpose': areaPurpose,
        'officialLandPrice': officialLandPrice,
        'totalLandPrice': totalLandPrice,
        'address': address,
        'pnu': pnu,
        'lineName': lineName,
        'stationName': stationName,
        'distance': distance,
      };

  @override
  String toString() {
    return 'DealLandItem(region1: $region1, region2: $region2, region3: $region3, bunji: $bunji, jibunAddress: $jibunAddress, lotArea: $lotArea, lotAreaPy: $lotAreaPy, areaPurpose: $areaPurpose, officialLandPrice: $officialLandPrice, totalLandPrice: $totalLandPrice, address: $address, pnu: $pnu, lineName: $lineName, stationName: $stationName, distance: $distance)';
  }
}
