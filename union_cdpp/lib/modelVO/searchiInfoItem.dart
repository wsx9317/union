class SearchInfoItem {
  String? startPrice;
  String? endPrice;
  List<String>? searchLocationTypeList;
  List<String>? filterTypeList;
  String? startLotPy;
  String? endLotPy;
  String? startFloorPy;
  String? endFloorPy;

  SearchInfoItem({
    this.startPrice,
    this.endPrice,
    this.searchLocationTypeList,
    this.filterTypeList,
    this.startLotPy,
    this.endLotPy,
    this.startFloorPy,
    this.endFloorPy,
  });

  SearchInfoItem.fromJson(Map<String, dynamic> json)
      : startPrice = json['startPrice'] as String?,
        endPrice = json['endPrice'] as String?,
        searchLocationTypeList = json['searchLocationTypeList'] as List<String>?,
        filterTypeList = json['filterTypeList'] as List<String>?,
        startLotPy = json['startLotPy'] as String?,
        endLotPy = json['endLotPy'] as String?,
        startFloorPy = json['startFloorPy'] as String?,
        endFloorPy = json['endFloorPy'] as String?;

  Map<String, dynamic> toJson() => {
        'startPrice': startPrice,
        'endPrice': endPrice,
        'searchLocationTypeList': searchLocationTypeList,
        'filterTypeList': filterTypeList,
        'startLotPy': startLotPy,
        'endLotPy': endLotPy,
        'startFloorPy': startFloorPy,
        'endFloorPy': endFloorPy,
      };

  @override
  String toString() {
    return 'SearchInfoItem(startPrice: $startPrice, endPrice: $endPrice, searchLocationTypeList: $searchLocationTypeList, filterTypeList: $filterTypeList,startLotPy: $startLotPy, endLotPy: $endLotPy, startFloorPy: $startFloorPy, endFloorPy: $endFloorPy)';
  }
}
