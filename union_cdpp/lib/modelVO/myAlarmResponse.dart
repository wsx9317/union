import 'package:unionCDPP/modelVO/myAlarmItem.dart';

class MyAlarmResponse {
  final List<MyAlarmItem>? list;
  final Map<String, dynamic>? commonInfo;

  MyAlarmResponse({
    this.list,
    this.commonInfo,
  });

  MyAlarmResponse.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)?.map((dynamic e) => MyAlarmItem.fromJson(e as Map<String, dynamic>)).toList(),
        commonInfo = json['commonInfo'] as Map<String, dynamic>;

  Map<String, dynamic> toJson() => {
        'list': list?.map((e) => e.toJson()).toList(),
        'commonInfo': commonInfo,
      };

  @override
  String toString() {
    return 'MyAlarmResponse(commonInfo:$commonInfo,list:$list)';
  }
}
