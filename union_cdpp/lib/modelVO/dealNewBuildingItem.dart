class DealNewBuildingItem {
  String? dealLandNo;
  String? dealNo;

  String? buildingArea;
  String? landUsage;
  String? parkingNum;
  String? totalFloorArea;
  String? buildingCoverage;
  String? elevator;
  String? upperFloorArea;
  String? lowerFloorArea;
  String? totalFloorRatio;
  String? lowerNum;
  String? upperNum;
  String? etc;
  String? owner;

  DealNewBuildingItem({
    this.dealLandNo,
    this.dealNo,
    this.buildingArea,
    this.landUsage,
    this.parkingNum,
    this.totalFloorArea,
    this.buildingCoverage,
    this.elevator,
    this.upperFloorArea,
    this.lowerFloorArea,
    this.totalFloorRatio,
    this.lowerNum,
    this.upperNum,
    this.etc,
    this.owner,
  });

  DealNewBuildingItem.fromJson(Map<String, dynamic> json)
      : dealLandNo = json['dealLandNo'] as String?,
        dealNo = json['dealNo'] as String?,
        buildingArea = json['buildingArea'] as String?,
        landUsage = json['landUsage'] as String?,
        parkingNum = json['parkingNum'] as String?,
        totalFloorArea = json['totalFloorArea'] as String?,
        buildingCoverage = json['buildingCoverage'] as String?,
        elevator = json['elevator'] as String?,
        upperFloorArea = json['upperFloorArea'] as String?,
        lowerFloorArea = json['lowerFloorArea'] as String?,
        totalFloorRatio = json['totalFloorRatio'] as String?,
        lowerNum = json['lowerNum'] as String?,
        upperNum = json['upperNum'] as String?,
        etc = json['etc'] as String?,
        owner = json['owner'] as String?;

  Map<String, dynamic> toJson() => {
        'dealLandNo': dealLandNo,
        'dealNo': dealNo,
        'buildingArea': buildingArea,
        'landUsage': landUsage,
        'parkingNum': parkingNum,
        'totalFloorArea': totalFloorArea,
        'buildingCoverage': buildingCoverage,
        'elevator': elevator,
        'upperFloorArea': upperFloorArea,
        'lowerFloorArea': lowerFloorArea,
        'totalFloorRatio': totalFloorRatio,
        'lowerNum': lowerNum,
        'upperNum': upperNum,
        'etc': etc,
        'owner': owner,
      };

  @override
  String toString() {
    return 'DealNewBuildingItem(dealLandNo: $dealLandNo, dealNo: $dealNo, buildingArea: $buildingArea, landUsage: $landUsage, parkingNum: $parkingNum, totalFloorArea: $totalFloorArea, buildingCoverage: $buildingCoverage, elevator: $elevator, upperFloorArea: $upperFloorArea, lowerFloorArea: $lowerFloorArea, totalFloorRatio: $totalFloorRatio, lowerNum: $lowerNum, upperNum: $upperNum, etc: $etc, owner: $owner)';
  }
}
