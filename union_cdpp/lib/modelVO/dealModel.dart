class DealModel {
  int? myDealSeq;
  String? myDealType;
  String? myDealTitle;
  String? myDealImg;
  List? myDealPjtList;
  List? myDealPjtColorList;
  String? myDealDesc;
  String? myDealStatus1;
  String? myDealStatus2;
  String? myDealStatus3;
  double? myDealPrice;
  double? myDealTotalFloorArea;
  double? myDealLandArea;
  List? myDealLotInfoList;
  String? createDateTime;
  String? updateDateTime;
  String? useYN;
  double? page;

  DealModel({
    this.myDealSeq,
    this.myDealType,
    this.myDealTitle,
    this.myDealImg,
    this.myDealPjtList,
    this.myDealPjtColorList,
    this.myDealDesc,
    this.myDealStatus1,
    this.myDealStatus2,
    this.myDealStatus3,
    this.myDealPrice,
    this.myDealTotalFloorArea,
    this.myDealLandArea,
    this.myDealLotInfoList,
    this.createDateTime,
    this.updateDateTime,
    this.useYN,
    this.page,
  });

  @override
  String toString() {
    return 'DealModel(myDealSeq:$myDealSeq, myDealType:$myDealType, myDealTitle:$myDealTitle, myDealImg:$myDealImg, myDealPjtList:$myDealPjtList, myDealPjtColorList:$myDealPjtColorList, myDealDesc:$myDealDesc, myDealStatus1:$myDealStatus1, myDealStatus2:$myDealStatus2, myDealStatus3:$myDealStatus3, myDealPrice:$myDealPrice,myDealTotalFloorArea:$myDealTotalFloorArea,myDealLandArea:$myDealLandArea, myDealLotInfoList:$myDealLotInfoList, createDateTime:$createDateTime, updateDateTime:$updateDateTime, useYN:$useYN, page:$page)';
  }

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      myDealSeq: json['myDealSeq'] as int?,
      myDealType: json['myDealType'] as String?,
      myDealTitle: json['myDealTitle'] as String?,
      myDealImg: json['myDealImg'] as String?,
      myDealPjtList: json['myDealPjtList'] as List?,
      myDealPjtColorList: json['myDealPjtColorList'] as List?,
      myDealDesc: json['myDealDesc'] as String?,
      myDealStatus1: json['myDealStatus1'] as String?,
      myDealStatus2: json['myDealStatus2'] as String?,
      myDealStatus3: json['myDealStatus3'] as String?,
      myDealPrice: json['myDealPrice'] as double?,
      myDealTotalFloorArea: json['myDealTotalFloorArea'] as double?,
      myDealLandArea: json['myDealLandArea'] as double?,
      myDealLotInfoList: json['myDealLotInfoList'] as List?,
      createDateTime: json['createDateTime'] as String?,
      updateDateTime: json['updateDateTime'] as String?,
      useYN: json['useYN'] as String?,
      page: json['page'] as double?,
    );
  }

  Map<String, dynamic> toJson() => {
        'myDealSeq': myDealSeq,
        'myDealType': myDealType,
        'myDealTitle': myDealTitle,
        'myDealImg': myDealImg,
        'myDealPjtList': myDealPjtList,
        'myDealPjtColorList': myDealPjtColorList,
        'myDealDesc': myDealDesc,
        'myDealStatus1': myDealStatus1,
        'myDealStatus2': myDealStatus2,
        'myDealStatus3': myDealStatus3,
        'myDealPrice': myDealPrice,
        'myDealTotalFloorArea': myDealTotalFloorArea,
        'myDealLandArea': myDealLandArea,
        'myDealLotInfoList': myDealLotInfoList,
        'createDateTime': createDateTime,
        'updateDateTime': updateDateTime,
        'page': page,
        'useYN': useYN,
      };
}
