import 'package:unionCDPP/modelVO/dealRentRollItem.dart';

class DealRentRollResponse {
  List<DealRentRollItem>? rentrollList;

  DealRentRollResponse({
    this.rentrollList,
  });

  DealRentRollResponse.fromJson(Map<String, dynamic> json)
      : rentrollList = (json['rentrollList'] as List?)?.map((dynamic e) => DealRentRollItem.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'rentrollList': rentrollList?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'DealRentRollResponse(rentrollList:$rentrollList)';
  }
}
