import 'package:unionCDPP/modelVO/dealBuildingItem.dart';
import 'package:unionCDPP/modelVO/dealLandItem.dart';
import 'package:unionCDPP/modelVO/dealLotItem.dart';
import 'package:unionCDPP/modelVO/dealMasterItem.dart';
import 'package:unionCDPP/modelVO/dealRentRollItem.dart';
import 'package:unionCDPP/modelVO/fileItem.dart';

class DealMasterSetting {
  // 딜마스터 부분
  DealMasterItem? dealMaster;
  DealLandItem? landItem;
  List<DealLotItem>? lotList;
  DealBuildingItem? building;
  List<DealRentRollItem>? rentrollList;
  List<FileItem>? fileInfoList;

  DealMasterSetting({
    this.dealMaster,
    this.landItem,
    this.lotList,
    this.building,
    this.rentrollList,
    this.fileInfoList,
  });

  DealMasterSetting.fromJson(Map<String, dynamic> json)
      : dealMaster = DealMasterItem.fromJson(json['dealMaster'] as Map<String, dynamic>),
        // dealMaster = DealMasterItem.fromJson(json['dealMaster'] as Map<String, dynamic>),
        lotList = (json['lotList'] as List?)?.map((dynamic e) => DealLotItem.fromJson(e as Map<String, dynamic>)).toList(),
        landItem = DealLandItem.fromJson(json['landItem'] as Map<String, dynamic>),
        building = DealBuildingItem.fromJson(json['building'] as Map<String, dynamic>),
        rentrollList = (json['rentrollList'] as List?)?.map((dynamic e) => DealRentRollItem.fromJson(e as Map<String, dynamic>)).toList(),
        fileInfoList = (json['fileInfoList'] as List?)?.map((dynamic e) => FileItem.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'dealMaster': dealMaster,
        'building': building,
        'lotList': lotList?.map((e) => e.toJson()).toList(),
        'rentrollList': rentrollList?.map((e) => e.toJson()).toList(),
        'fileInfoList': fileInfoList?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'DealMasterSetting(dealMaster: $dealMaster, landItem: $landItem, lotList: $lotList, building: $building, rentrollList: $rentrollList, fileInfoList: $fileInfoList)';
  }
}
