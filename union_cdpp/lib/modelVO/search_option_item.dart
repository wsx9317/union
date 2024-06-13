class SearchOptionItme {
  int? page;
  int? rowSize;
  String? searchType;
  String? searchVal;

  SearchOptionItme({
    this.searchType,
    this.searchVal,
    this.rowSize,
    this.page,
  });

  @override
  String toString() {
    return 'SearchOptionItme(searchType: $searchType, searchVal: $searchVal, rowSize: $rowSize, page: $page)';
  }

  factory SearchOptionItme.fromJson(Map<String, dynamic> json) {
    return SearchOptionItme(
      page: json['page'] as int?,
      rowSize: json['rowSize'] as int?,
      searchType: json['searchType'] as String?,
      searchVal: json['searchVal'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'page': page,
        'rowSize': rowSize,
        'searchType': searchType,
        'searchVal': searchVal,
      };
}
