import 'package:union_admin/modelVO/dealDomiItem.dart';

class DealDomiResponse {
  final List<DealDomiItem>? list;
  final Map<String, dynamic>? commonInfo;

  DealDomiResponse({
    this.list,
    this.commonInfo,
  });

  DealDomiResponse.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)?.map((dynamic e) => DealDomiItem.fromJson(e as Map<String, dynamic>)).toList(),
        commonInfo = json['commonInfo'] as Map<String, dynamic>;

  Map<String, dynamic> toJson() => {
        'list': list?.map((e) => e.toJson()).toList(),
        'commonInfo': commonInfo,
      };

  @override
  String toString() {
    return 'DealDomiResponse(commonInfo:$commonInfo,list:$list)';
  }
}
