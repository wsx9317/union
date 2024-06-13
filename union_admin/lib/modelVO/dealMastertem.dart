class DealMasterItem {
  String? userNo;
  String? dealNo;
  String? title;
  String? gubun;
  String? type;
  String? status;
  String? dealStatus;
  String? category;
  String? register;
  String? registerEtc;
  String? address;
  String? addressDtl;
  String? areaPos;
  String? asking;
  String? negotiationType;
  String? assetStatus;
  String? evacuationType;
  String? evacuationPeriod;
  String? evacuationChk;
  String? owner;
  String? stationDistance;
  String? stationName;
  String? additional;
  String? additionalEtc;
  String? delYn;
  String? createDate;
  String? createId;
  String? updateDate;
  String? updateId;
  String? filePath;
  String? s3FileUrl;
  String? landLotArea;
  String? landLotAreaPy;
  String? landTotalFloorArea;
  String? landTotalFloorAreaPy;
  String? bdLotArea;
  String? bdLotAreaPy;
  String? bdTotalFloorArea;
  String? bdTotalFloorAreaPy;
  String? statusNm;
  String? subGrpCd;
  String? transactionStatusNm;
  String? latitude;
  String? longitude;
  List? labelList;

  DealMasterItem({
    this.userNo,
    this.dealNo,
    this.title,
    this.gubun,
    this.type,
    this.status,
    this.dealStatus,
    this.category,
    this.register,
    this.registerEtc,
    this.address,
    this.addressDtl,
    this.areaPos,
    this.asking,
    this.negotiationType,
    this.assetStatus,
    this.evacuationType,
    this.evacuationPeriod,
    this.evacuationChk,
    this.owner,
    this.stationDistance,
    this.stationName,
    this.additional,
    this.additionalEtc,
    this.delYn,
    this.createDate,
    this.createId,
    this.updateDate,
    this.updateId,
    this.filePath,
    this.s3FileUrl,
    this.landLotArea,
    this.landLotAreaPy,
    this.landTotalFloorArea,
    this.landTotalFloorAreaPy,
    this.bdLotArea,
    this.bdLotAreaPy,
    this.bdTotalFloorArea,
    this.bdTotalFloorAreaPy,
    this.statusNm,
    this.subGrpCd,
    this.transactionStatusNm,
    this.latitude,
    this.longitude,
    this.labelList,
  });

  DealMasterItem.fromJson(Map<String, dynamic> json)
      : userNo = json['userNo'] as String?,
        dealNo = json['dealNo'] as String?,
        title = json['title'] as String?,
        gubun = json['gubun']! as String?,
        type = json['type'] as String?,
        status = json['status'] as String?,
        dealStatus = json['dealStatus'] as String?,
        category = json['category'] as String?,
        register = json['register'] as String?,
        registerEtc = json['registerEtc'] as String?,
        address = json['address'] as String?,
        addressDtl = json['addressDtl'] as String?,
        areaPos = json['areaPos'] as String?,
        asking = json['asking'] as String?,
        negotiationType = json['negotiationType'] as String?,
        assetStatus = json['assetStatus'] as String?,
        evacuationType = json['evacuationType'] as String?,
        evacuationPeriod = json['evacuationPeriod'] as String?,
        evacuationChk = json['evacuationChk'] as String?,
        owner = json['owner'] as String?,
        stationDistance = json['stationDistance'] as String?,
        stationName = json['stationName'] as String?,
        additional = json['additional'] as String?,
        additionalEtc = json['additionalEtc'] as String?,
        delYn = json['delYn'] as String?,
        createDate = json['createDate'] as String?,
        createId = json['createId'] as String?,
        updateDate = json['updateDate'] as String?,
        updateId = json['updateId'] as String?,
        filePath = json['filePath'] as String?,
        s3FileUrl = json['s3FileUrl'] as String?,
        landLotArea = json['landLotArea'] as String?,
        landLotAreaPy = json['landLotAreaPy'] as String?,
        landTotalFloorArea = json['landTotalFloorArea'] as String?,
        landTotalFloorAreaPy = json['landTotalFloorAreaPy'] as String?,
        bdLotArea = json['bdLotArea'] as String?,
        bdLotAreaPy = json['bdLotAreaPy'] as String?,
        bdTotalFloorArea = json['bdTotalFloorArea'] as String?,
        bdTotalFloorAreaPy = json['bdTotalFloorAreaPy'] as String?,
        statusNm = json['statusNm'] as String?,
        subGrpCd = json['subGrpCd'] as String?,
        transactionStatusNm = json['transactionStatusNm'] as String?,
        latitude = json['latitude'] as String?,
        longitude = json['longitude'] as String?,
        labelList = json['labelList'] as List?;

  Map<String, dynamic> toJson() => {
        'userNo': userNo,
        'dealNo': dealNo,
        'title': title,
        'gubun': gubun,
        'type': type,
        'status': status,
        'dealStatus': dealStatus,
        'category': category,
        'register': register,
        'registerEtc': registerEtc,
        'address': address,
        'addressDtl': addressDtl,
        'areaPos': areaPos,
        'asking': asking,
        'negotiationType': negotiationType,
        'assetStatus': assetStatus,
        'evacuationType': evacuationType,
        'evacuationPeriod': evacuationPeriod,
        'evacuationChk': evacuationChk,
        'owner': owner,
        'stationDistance': stationDistance,
        'stationName': stationName,
        'additional': additional,
        'additionalEtc': additionalEtc,
        'delYn': delYn,
        'createDate': createDate,
        'createId': createId,
        'updateDate': updateDate,
        'updateId': updateId,
        'filePath ': filePath,
        's3FileUrl': s3FileUrl,
        'landLotArea': landLotArea,
        'landLotAreaPy': landLotAreaPy,
        'landTotalFloorArea': landTotalFloorArea,
        'landTotalFloorAreaPy': landTotalFloorAreaPy,
        'bdLotArea': bdLotArea,
        'bdLotAreaPy': bdLotAreaPy,
        'bdTotalFloorArea': bdTotalFloorArea,
        'bdTotalFloorAreaPy': bdTotalFloorAreaPy,
        'statusNm': statusNm,
        'subGrpCd': subGrpCd,
        'transactionStatusNm': transactionStatusNm,
        'latitude': latitude,
        'longitude': longitude,
        'labelList': labelList,
      };

  @override
  // String toString() {
  //   return 'DealMasterItem(userNo: $userNo, dealNo: $dealNo, title: $title, gubun: $gubun, type: $type, status: $status, dealStatus: $dealStatus, category: $category, register: $register, registerEtc: $registerEtc, address: $address, addressDtl: $addressDtl, areaPos: $areaPos, asking: $asking,  negotiationType: $negotiationType, assetStatus: $assetStatus, evacuationType: $evacuationType, evacuationPeriod: $evacuationPeriod, evacuationChk: $evacuationChk, owner: $owner, stationDistance: $stationDistance, stationName: $stationName, additional: $additional, additionalEtc: $additionalEtc, delYn: $delYn, createDate: $createDate, createId: $createId, updateDate: $updateDate, filePath: $filePath, s3FileUrl: $s3FileUrl, landLotArea: $landLotArea, landLotAreaPy: $landLotAreaPy, landTotalFloorArea: $landTotalFloorArea, landTotalFloorAreaPy: $landTotalFloorAreaPy, bdLotArea: $bdLotArea, bdLotAreaPy: $bdLotAreaPy, bdTotalFloorArea: $bdTotalFloorArea, bdTotalFloorAreaPy: $bdTotalFloorAreaPy, statusNm: $statusNm, subGrpCd: $subGrpCd, latitude:$latitude, longitude:$longitude, labelList: $labelList)';
  // }
  String toString() {
    return 'MyDealItem(userNo: $userNo, dealNo: $dealNo, title: $title, gubun: $gubun, type: $type, status: $status, dealStatus: $dealStatus, category: $category, register: $register, registerEtc: $registerEtc, address: $address, addressDtl: $addressDtl, areaPos: $areaPos, asking: $asking,  negotiationType: $negotiationType, assetStatus: $assetStatus, evacuationType: $evacuationType, evacuationPeriod: $evacuationPeriod, evacuationChk: $evacuationChk, owner: $owner, stationDistance: $stationDistance, stationName: $stationName, additional: $additional, additionalEtc: $additionalEtc, delYn: $delYn, createDate: $createDate, createId: $createId, updateDate: $updateDate, filePath: $filePath, s3FileUrl: $s3FileUrl, landLotArea: $landLotArea, landLotAreaPy: $landLotAreaPy, landTotalFloorArea: $landTotalFloorArea, landTotalFloorAreaPy: $landTotalFloorAreaPy, bdLotArea: $bdLotArea, bdLotAreaPy: $bdLotAreaPy, bdTotalFloorArea: $bdTotalFloorArea, bdTotalFloorAreaPy: $bdTotalFloorAreaPy, statusNm: $statusNm, subGrpCd: $subGrpCd, transactionStatusNm: $transactionStatusNm, latitude:$latitude, longitude:$longitude, labelList: $labelList)';
  }
}
