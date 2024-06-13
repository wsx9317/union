import 'package:unionCDPP/modelVO/noticeItem.dart';
import 'package:unionCDPP/modelVO/search_option_item.dart';

class NoticeResponse {
  final List<NoticeItem>? list;
  final Map<String, dynamic>? commonInfo;

  NoticeResponse({
    this.list,
    this.commonInfo,
  });

  NoticeResponse.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)?.map((dynamic e) => NoticeItem.fromJson(e as Map<String, dynamic>)).toList(),
        commonInfo = json['commonInfo'] as Map<String, dynamic>;

  Map<String, dynamic> toJson() => {
        'list': list?.map((e) => e.toJson()).toList(),
        'commonInfo': commonInfo,
      };

  @override
  String toString() {
    return 'NoticeResponse(commonInfo:$commonInfo,list:$list)';
  }
}
