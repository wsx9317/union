class DealCountItem {
  int? normalCnt;
  int? domiCnt;
  int? endCnt;

  DealCountItem({this.normalCnt, this.domiCnt, this.endCnt});

  DealCountItem.fromJson(Map<String, dynamic> json)
      : normalCnt = json['normalCnt'] as int?,
        domiCnt = json['domiCnt'] as int?,
        endCnt = json['endCnt'] as int?;

  Map<String, dynamic> toJson() => {
        'normalCnt': normalCnt,
        'domiCnt': domiCnt,
        'endCnt': endCnt,
      };

  @override
  String toString() {
    return 'DealCountItem(normalCnt: $normalCnt, domiCnt: $domiCnt, endCnt: $endCnt)';
  }
}
