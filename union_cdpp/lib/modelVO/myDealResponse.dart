import 'package:unionCDPP/modelVO/myDealtem.dart';

class MyDealResponse {
  List<MyDealItem>? list;
  Map<String, dynamic>? commonInfo;

  MyDealResponse({
    this.list,
    this.commonInfo,
  });

  MyDealResponse.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)?.map((dynamic e) => MyDealItem.fromJson(e as Map<String, dynamic>)).toList(),
        commonInfo = json['commonInfo'] as Map<String, dynamic>;

  Map<String, dynamic> toJson() => {
        'list': list?.map((e) => e.toJson()).toList(),
        'commonInfo': commonInfo,
      };

  @override
  String toString() {
    return 'MyDealResponse(commonInfo:$commonInfo,list:$list)';
  }
}
