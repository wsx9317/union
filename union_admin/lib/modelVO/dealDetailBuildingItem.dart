import 'package:union_admin/modelVO/dealBuildingItem.dart';
import 'package:union_admin/modelVO/dealLabelItem.dart';
import 'package:union_admin/modelVO/dealMastertem.dart';
import 'package:union_admin/modelVO/dealRentRollItem.dart';
import 'package:union_admin/modelVO/dominantItem.dart';
import 'package:union_admin/modelVO/fileItem.dart';

class DealDetailBuildingItem {
  DealMasterItem? dealMaster;
  List<FileItem>? fileList;
  DominantItem? dominant;
  DealBuildingItem? building;
  List<DealRentRollItem>? rentrollList;
  List<DealLabelItem>? labelList;

  DealDetailBuildingItem({
    this.dealMaster,
    this.fileList,
    this.dominant,
    this.building,
    this.rentrollList,
    this.labelList,
  });

  DealDetailBuildingItem.fromJson(Map<String, dynamic> json)
      : dealMaster = json['dealMaster'] != null ? DealMasterItem.fromJson(json['dealMaster'] as Map<String, dynamic>) : null,
        fileList = (json['fileList'] as List<dynamic>?)?.map((dynamic e) => FileItem.fromJson(e as Map<String, dynamic>)).toList(),
        dominant = json['dominant'] != null ? DominantItem.fromJson(json['dominant'] as Map<String, dynamic>) : null,
        building = json['building'] != null ? DealBuildingItem.fromJson(json['building'] as Map<String, dynamic>) : null,
        rentrollList =
            (json['rentrollList'] as List<dynamic>?)?.map((dynamic e) => DealRentRollItem.fromJson(e as Map<String, dynamic>)).toList(),
        labelList = (json['labelList'] as List<dynamic>?)?.map((dynamic e) => DealLabelItem.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'dealMaster': dealMaster,
        'fileList': fileList,
        'dominant': dominant,
        'building': building,
        'rentrollList': rentrollList,
        'labelList': labelList,
      };

  @override
  String toString() {
    return 'DealDetailBuildingItem(dealMaster: $dealMaster, fileList: $fileList, dominant :$dominant building: $building, rentrollList: $rentrollList, labelList:$labelList)';
  }
}
