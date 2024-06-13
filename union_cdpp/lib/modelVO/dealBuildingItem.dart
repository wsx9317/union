class DealBuildingItem {
  String? dealBdNo;
  String? dealNo;
  String? buildingName;
  String? lotArea;
  String? totalFloorArea;
  String? areaPurpose;
  String? totalFloorRatio;
  String? bdCoverageRatio;
  String? mainPurpose;
  String? mainStruct;
  String? ccd;
  String? lowerNum;
  String? upperNum;
  String? elevator;
  String? parkingNum;
  String? officialLandPrice;
  String? totalLandPrice;
  String? deposit;
  String? depositChk;
  String? monthly;
  String? monthlyChk;
  String? loan;
  String? roomNum;
  String? reModel;
  String? bdUniqueId;
  String? bdAdditional;
  String? etc;
  String? pnu;
  String? bdDistrictUnitPlan;

  DealBuildingItem({
    this.dealBdNo,
    this.dealNo,
    this.buildingName,
    this.lotArea,
    this.totalFloorArea,
    this.areaPurpose,
    this.totalFloorRatio,
    this.bdCoverageRatio,
    this.mainPurpose,
    this.mainStruct,
    this.ccd,
    this.lowerNum,
    this.upperNum,
    this.elevator,
    this.parkingNum,
    this.officialLandPrice,
    this.totalLandPrice,
    this.deposit,
    this.depositChk,
    this.monthly,
    this.monthlyChk,
    this.loan,
    this.roomNum,
    this.reModel,
    this.bdUniqueId,
    this.bdAdditional,
    this.etc,
    this.pnu,
    this.bdDistrictUnitPlan,
  });

  DealBuildingItem.fromJson(Map<String, dynamic> json)
      : dealBdNo = json['dealBdNo'] as String?,
        dealNo = json['dealNo'] as String?,
        buildingName = json['buildingName'] as String?,
        lotArea = json['lotArea'] as String?,
        totalFloorArea = json['totalFloorArea'] as String?,
        areaPurpose = json['areaPurpose'] as String?,
        totalFloorRatio = json['totalFloorRatio'] as String?,
        bdCoverageRatio = json['bdCoverageRatio'] as String?,
        mainPurpose = json['mainPurpose'] as String?,
        mainStruct = json['mainStruct'] as String?,
        ccd = json['ccd'] as String?,
        lowerNum = json['lowerNum'] as String?,
        upperNum = json['upperNum'] as String?,
        elevator = json['elevator'] as String?,
        parkingNum = json['parkingNum'] as String?,
        officialLandPrice = json['officialLandPrice'] as String?,
        totalLandPrice = json['totalLandPrice'] as String?,
        deposit = json['deposit'] as String?,
        depositChk = json['depositChk'] as String?,
        monthly = json['monthly'] as String?,
        monthlyChk = json['monthlyChk'] as String?,
        loan = json['loan'] as String?,
        roomNum = json['roomNum'] as String?,
        reModel = json['reModel'] as String?,
        bdUniqueId = json['bdUniqueId'] as String?,
        bdAdditional = json['bdAdditional'] as String?,
        etc = json['etc'] as String?,
        pnu = json['pnu'] as String?,
        bdDistrictUnitPlan = json['bdDistrictUnitPlan'] as String?;

  Map<String, dynamic> toJson() => {
        'dealBdNo': dealBdNo,
        'dealNo': dealNo,
        'buildingName': buildingName,
        'lotArea': lotArea,
        'totalFloorArea': totalFloorArea,
        'areaPurpose': areaPurpose,
        'totalFloorRatio': totalFloorRatio,
        'bdCoverageRatio': bdCoverageRatio,
        'mainPurpose': mainPurpose,
        'mainStruct': mainStruct,
        'ccd': ccd,
        'lowerNum': lowerNum,
        'upperNum': upperNum,
        'elevator': elevator,
        'parkingNum': parkingNum,
        'officialLandPrice': officialLandPrice,
        'totalLandPrice': totalLandPrice,
        'deposit': deposit,
        'depositChk': depositChk,
        'monthly': monthly,
        'monthlyChk': monthlyChk,
        'loan': loan,
        'roomNum': roomNum,
        'reModel': reModel,
        'bdUniqueId': bdUniqueId,
        'bdAdditional': bdAdditional,
        'etc': etc,
        'pnu': pnu,
        'bdDistrictUnitPlan': bdDistrictUnitPlan,
      };

  @override
  String toString() {
    return 'DealBuildingItem(dealBdNo: $dealBdNo, dealNo: $dealNo, buildingName: $buildingName, lotArea: $lotArea,totalFloorArea: $totalFloorArea, areaPurpose: $areaPurpose, totalFloorRatio: $totalFloorRatio, bdCoverageRatio:$bdCoverageRatio, mainPurpose: $mainPurpose, mainStruct: $mainStruct, ccd: $ccd, lowerNum: $lowerNum, upperNum: $upperNum, elevator: $elevator, parkingNum: $parkingNum, officialLandPrice: $officialLandPrice, totalLandPrice: $totalLandPrice, deposit: $deposit, depositChk: $depositChk, monthly: $monthly, monthlyChk: $monthlyChk, loan: $loan, roomNum: $roomNum, reModel: $reModel, bdUniqueId: $bdUniqueId, bdAdditional: $bdAdditional, etc: $etc, pnu:$pnu, bdDistrictUnitPlan: $bdDistrictUnitPlan)';
  }
}
