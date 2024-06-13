class DealMasterItem {
  String? pnu;
  String? title;
  String? gubun; //1: 일반, 2독점
  String? type; //L: 신축, B:건물
  String? status; //1: 거래중, 9:완료
  String? dealStatus; // 1:거래중, 2:거래완료, 0:보류
  String? category; //1: 매각, 2:위탁운영
  String? register; // 등록자, 1:중개사, 2:소유주, 3:시행사, 4:기타
  String? registerEtc; // 등록자 기타
  String? address;
  String? addressDtl;
  String? areaPos; //PNU앞5지리',
  String? asking; //'희망매각가',
  String? negotiationType; //'가격협의, 1:가능,2:불가능,3:협의',
  String? assetStatus; //'자산현황, 1:명도예정/명도중, 2:공실, 3:나대지, 4:인허가/착공'
  String? evacuationType; //'명도타입, 0:none, 1:전층책임명도,2:일부책임명도,3:불가능,4:협의'
  String? evacuationPeriod; //'명도기간(개월)'
  String? evacuationChk; //'명도 협의 체크'
  String? owner; //'소유자, 1:개인/법인,2:시행사,3:브릿지/PF'
  String? stationDistance; //'지하철과의거리(m)',
  String? stationName; //'인접지하철',
  String? additional; //'특이사항, 1:대로변, 2:역세권, 3:대학가, 4:상권, 5:관광지역, 6:대형공원'
  String? additionalEtc; //'특이사항 기타',

  DealMasterItem({
    this.pnu,
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
  });

  DealMasterItem.fromJson(Map<String, dynamic> json)
      : pnu = json['pnu'] as String?,
        title = json['ptitlenu'] as String?,
        gubun = json['gubun'] as String?,
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
        additionalEtc = json['additionalEtc'] as String?;

  Map<String, dynamic> toJson() => {
        'pnu': pnu,
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
      };

  @override
  String toString() {
    return 'DealMasterItem(pnu: $pnu, title: $title, gubun: $gubun, type: $type, status: $status, dealStatus: $dealStatus, category: $category, register: $register, registerEtc:$registerEtc, address: $address, addressDtl: $addressDtl, areaPos: $areaPos, asking: $asking, negotiationType: $negotiationType, assetStatus: $assetStatus, evacuationType: $evacuationType, evacuationPeriod: $evacuationPeriod, evacuationChk: $evacuationChk, owner: $owner, stationDistance: $stationDistance, stationName: $stationName, additional: $additional, additionalEtc: $additionalEtc)';
  }
}
