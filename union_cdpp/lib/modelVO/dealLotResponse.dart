import 'package:unionCDPP/modelVO/dealLotItem.dart';

class DealLotResponse {
  List<DealLotItem>? lotList;

  DealLotResponse({
    this.lotList,
  });

  DealLotResponse.fromJson(Map<String, dynamic> json)
      : lotList = (json['lotList'] as List?)?.map((dynamic e) => DealLotItem.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'lotList': lotList?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'DealLotResponse(lotList:$lotList)';
  }
}
