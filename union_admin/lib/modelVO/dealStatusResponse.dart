import 'package:union_admin/modelVO/dealStatusItem.dart';

class DealStatusResponse {
  final List<DealStatusItem>? list;
  final Map<String, dynamic>? commonInfo;

  DealStatusResponse({
    this.list,
    this.commonInfo,
  });

  DealStatusResponse.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)?.map((dynamic e) => DealStatusItem.fromJson(e as Map<String, dynamic>)).toList(),
        commonInfo = json['commonInfo'] as Map<String, dynamic>;

  Map<String, dynamic> toJson() => {
        'list': list?.map((e) => e.toJson()).toList(),
        'commonInfo': commonInfo,
      };

  @override
  String toString() {
    return 'DealStatusResponse(commonInfo:$commonInfo,list:$list)';
  }
}
