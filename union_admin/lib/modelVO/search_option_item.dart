class SearchOptionItme {
  int? page;
  int? rowSize;
  String? searchType1;
  String? searchType2;
  String? searchVal;
  String? dateType;
  String? gubun;
  String? startDate;
  String? endDate;
  String? orderType;
  String? order;
  String? dealNo;
  String? fileType;

  SearchOptionItme({
    this.rowSize,
    this.page,
    this.searchType1,
    this.searchType2,
    this.searchVal,
    this.dateType,
    this.gubun,
    this.startDate,
    this.endDate,
    this.orderType,
    this.order,
    this.dealNo,
    this.fileType,
  });

  factory SearchOptionItme.fromJson(Map<String, dynamic> json) {
    return SearchOptionItme(
      page: json['page'] as int?,
      rowSize: json['rowSize'] as int?,
      searchType1: json['searchType1'] as String?,
      searchType2: json['searchType2'] as String?,
      dateType: json['dateType'] as String?,
      gubun: json['gubun'] as String?,
      searchVal: json['searchVal'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      order: json['order'] as String?,
      orderType: json['orderType'] as String?,
      dealNo: json['dealNo'] as String?,
      fileType: json['fileType'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'page': page,
        'rowSize': rowSize,
        'searchType1': searchType1,
        'searchType2': searchType2,
        'searchVal': searchVal,
        'dateType': dateType,
        'gubun': gubun,
        'startDate': startDate,
        'endDate': endDate,
        'order': order,
        'orderType': orderType,
        'dealNo': dealNo,
        'fileType': fileType,
      };

  @override
  String toString() {
    return 'SearchOptionItme(page: $page, rowSize: $rowSize, searchType1: $searchType1, searchType2: $searchType2, searchVal: $searchVal, dateType: $dateType, gubun: $gubun, startDate: $startDate, endDate: $endDate, orderType: $orderType, order: $order, dealNo:$dealNo, fileType:$fileType)';
  }
}
