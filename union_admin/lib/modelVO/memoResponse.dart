import 'package:union_admin/modelVO/memoItem.dart';

class MemoResponse {
  final List<MemoItem>? list;
  final Map<String, dynamic>? commonInfo;

  MemoResponse({
    this.list,
    this.commonInfo,
  });

  MemoResponse.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)?.map((dynamic e) => MemoItem.fromJson(e as Map<String, dynamic>)).toList(),
        commonInfo = json['commonInfo'] as Map<String, dynamic>;

  Map<String, dynamic> toJson() => {
        'list': list?.map((e) => e.toJson()).toList(),
        'commonInfo': commonInfo,
      };

  @override
  String toString() {
    return 'MemoResponse(commonInfo:$commonInfo,list:$list)';
  }
}
