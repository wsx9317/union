import 'package:unionCDPP/modelVO/commonCdItem.dart';

class CommonCdResponse {
  final List<CommonCdItem>? list;

  CommonCdResponse({
    this.list,
  });

  CommonCdResponse.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)?.map((dynamic e) => CommonCdItem.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'list': list?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'CommonCdResponse(list:$list)';
  }
}
