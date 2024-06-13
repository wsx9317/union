import 'package:unionCDPP/modelVO/dealModel.dart';

class DealList {
  final List<DealModel>? list;

  DealList({this.list});

  DealList.fromJson(Map<String, dynamic> json)
      : list = (json['List'] as List?)?.map((dynamic e) => DealModel.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'List': list?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'DealList(list:$list)';
  }
}
