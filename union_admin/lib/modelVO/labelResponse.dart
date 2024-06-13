import 'package:union_admin/modelVO/labelEditItem.dart';

class LabelResponse {
  final List<LabelEditItem>? list;

  LabelResponse({
    this.list,
  });

  LabelResponse.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)?.map((dynamic e) => LabelEditItem.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'list': list?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'LabelResponse(list:$list)';
  }
}
