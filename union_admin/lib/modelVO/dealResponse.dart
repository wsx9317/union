import 'package:union_admin/modelVO/dealItem.dart';

class DealResponse {
  final List<DealItem>? list;
  final Map<String, dynamic>? commonInfo;

  DealResponse({
    this.list,
    this.commonInfo,
  });

  DealResponse.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)?.map((dynamic e) => DealItem.fromJson(e as Map<String, dynamic>)).toList(),
        commonInfo = json['commonInfo'] as Map<String, dynamic>;

  Map<String, dynamic> toJson() => {
        'list': list?.map((e) => e.toJson()).toList(),
        'commonInfo': commonInfo,
      };

  @override
  String toString() {
    return 'DealResponse(commonInfo:$commonInfo,list:$list)';
  }
}
