import 'package:unionCDPP/modelVO/dealBuildingItem.dart';
import 'package:unionCDPP/modelVO/dealLandItem.dart';
import 'package:unionCDPP/modelVO/dealLotItem.dart';
import 'package:unionCDPP/modelVO/dealRentRollItem.dart';
import 'package:unionCDPP/modelVO/dominantItem.dart';
import 'package:unionCDPP/modelVO/fileItem.dart';
import 'package:unionCDPP/modelVO/myDealtem.dart';

class MyDealDetailBuildingItem {
  int? page;
  int? rowSize;
  MyDealItem? dealMaster;
  List<FileItem>? fileList;
  DominantItem? dominant;
  DealBuildingItem? building;
  List<DealRentRollItem>? rentrollList;

  MyDealDetailBuildingItem({
    this.page,
    this.rowSize,
    this.dealMaster,
    this.fileList,
    this.dominant,
    this.building,
    this.rentrollList,
  });

  MyDealDetailBuildingItem.fromJson(Map<String, dynamic> json)
      : page = json['page'] as int?,
        rowSize = json['rowSize'] as int?,
        dealMaster = json['dealMaster'] != null ? MyDealItem.fromJson(json['dealMaster'] as Map<String, dynamic>) : null,
        fileList = (json['fileList'] as List<dynamic>?)?.map((dynamic e) => FileItem.fromJson(e as Map<String, dynamic>)).toList(),
        dominant = json['dominant'] != null ? DominantItem.fromJson(json['dominant'] as Map<String, dynamic>) : null,
        building = json['building'] != null ? DealBuildingItem.fromJson(json['building'] as Map<String, dynamic>) : null,
        rentrollList =
            (json['rentrollList'] as List<dynamic>?)?.map((dynamic e) => DealRentRollItem.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'page': page,
        'rowSize': rowSize,
        'dealMaster': dealMaster,
        'fileList': fileList,
        'dominant': dominant,
        'building': building,
        'rentrollList': rentrollList,
      };

  @override
  String toString() {
    return 'MyDealDetailBuildingItem(page:$page, rowSize:$rowSize, dealMaster: $dealMaster, fileList: $fileList, dominant :$dominant building: $building, rentrollList: $rentrollList)';
  }
}
