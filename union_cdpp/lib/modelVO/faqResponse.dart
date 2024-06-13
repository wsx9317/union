import 'package:unionCDPP/modelVO/faqItem.dart';

class FaqResponse {
  final List<FaqItem>? list;
  final Map<String, dynamic>? commonInfo;

  FaqResponse({this.list, this.commonInfo});

  FaqResponse.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)?.map((dynamic e) => FaqItem.fromJson(e as Map<String, dynamic>)).toList(),
        commonInfo = json['commonInfo'] as Map<String, dynamic>?;

  Map<String, dynamic> toJson() => {
        'list': list?.map((e) => e.toJson()).toList(),
        'totalCnt': commonInfo,
      };

  @override
  String toString() {
    return 'FaqResponse(commonInfo: $commonInfo, list:$list)';
  }
}
