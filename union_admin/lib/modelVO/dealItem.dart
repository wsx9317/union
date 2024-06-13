import 'package:union_admin/modelVO/labelItem.dart';

class DealItem {
  String? dealNo;
  String? createDate;
  String? labels;
  String? userName;
  String? title;
  String? office;
  String? asking;
  String? address;
  String? dayRemaining;
  String? lotArea;
  String? totalFloorArea;
  String? type;
  String? gubun;
  String? dealStatus;
  String? status;
  String? userId;
  List<LabelItem>? labelList;

  DealItem({
    this.dealNo,
    this.createDate,
    this.labels,
    this.userName,
    this.title,
    this.office,
    this.asking,
    this.address,
    this.dayRemaining,
    this.lotArea,
    this.totalFloorArea,
    this.type,
    this.gubun,
    this.dealStatus,
    this.status,
    this.userId,
    this.labelList,
  });

  DealItem.fromJson(Map<String, dynamic> json)
      : dealNo = json['dealNo'] as String?,
        createDate = json['createDate'] as String?,
        labels = json['labels'] as String?,
        userName = json['userName'] as String?,
        title = json['title'] as String?,
        office = json['office'] as String?,
        asking = json['asking'] as String?,
        address = json['address'] as String?,
        dayRemaining = json['dayRemaining'] as String?,
        lotArea = json['lotArea'] as String?,
        totalFloorArea = json['totalFloorArea'] as String?,
        type = json['type'] as String?,
        gubun = json['gubun'] as String?,
        dealStatus = json['dealStatus'] as String?,
        status = json['status'] as String?,
        userId = json['userId'] as String?,
        labelList = (json['labelList'] as List?)?.map((dynamic e) => LabelItem.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'dealNo': dealNo,
        'createDate': createDate,
        'labels': labels,
        'userName': userName,
        'title': title,
        'office': office,
        'asking': asking,
        'address': address,
        'dayRemaining': dayRemaining,
        'lotArea': lotArea,
        'totalFloorArea': totalFloorArea,
        'type': type,
        'gubun': gubun,
        'dealStatus': dealStatus,
        'status': status,
        'userId': userId,
        'labelList': labelList?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'DealItem(dealNo:$dealNo, createDate:$createDate, labels:$labels, userName:$userName, title:$title, office:$office, asking:$asking, address:$address, dayRemaining:$dayRemaining, lotArea:$lotArea, totalFloorArea:$totalFloorArea, type:$type, gubun:$gubun, dealStatus:$dealStatus, status:$status, userId:$userId, labelList:$labelList)';
  }
}
