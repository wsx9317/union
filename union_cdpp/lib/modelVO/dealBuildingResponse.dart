import 'package:unionCDPP/modelVO/dealBuildingItem.dart';

class DealBuildingResponse {
  final List<DealBuildingItem>? list;
  final int? totalCnt;
  final Map<String, dynamic>? subway;

  DealBuildingResponse({
    this.list,
    this.totalCnt,
    this.subway,
  });

  DealBuildingResponse.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)?.map((dynamic e) => DealBuildingItem.fromJson(e as Map<String, dynamic>)).toList(),
        totalCnt = json['totalCnt'] as int,
        subway = json['subway'] as Map<String, dynamic>;

  Map<String, dynamic> toJson() => {
        'list': list?.map((e) => e.toJson()).toList(),
        'totalCnt': totalCnt,
        'subway': subway,
      };

  @override
  String toString() {
    return 'DealBuildingResponse(subway:$subway, totalCnt:$totalCnt, list:$list)';
  }
}
