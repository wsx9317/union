import 'package:union_admin/modelVO/dealLabelItem.dart';
import 'package:union_admin/modelVO/dealLotItem.dart';
import 'package:union_admin/modelVO/dealMastertem.dart';
import 'package:union_admin/modelVO/dealNewBuildingItem.dart';
import 'package:union_admin/modelVO/dominantItem.dart';
import 'package:union_admin/modelVO/fileItem.dart';

class DealDetailLandItem {
  DealMasterItem? dealMaster;
  DominantItem? dominant;
  List<DealLotItem>? lotList;
  DealNewBuildingItem? land;
  List<FileItem>? fileList;
  List<DealLabelItem>? labelList;

  DealDetailLandItem({
    this.dealMaster,
    this.dominant,
    this.lotList,
    this.land,
    this.fileList,
    this.labelList,
  });

  DealDetailLandItem.fromJson(Map<String, dynamic> json)
      : dealMaster = json['dealMaster'] != null ? DealMasterItem.fromJson(json['dealMaster'] as Map<String, dynamic>) : null,
        dominant = json['dominant'] != null ? DominantItem.fromJson(json['dominant'] as Map<String, dynamic>) : null,
        lotList = (json['lotList'] as List<dynamic>?)?.map((dynamic e) => DealLotItem.fromJson(e as Map<String, dynamic>)).toList(),
        land = json['land'] != null ? DealNewBuildingItem.fromJson(json['land'] as Map<String, dynamic>) : null,
        fileList = (json['fileList'] as List<dynamic>?)?.map((dynamic e) => FileItem.fromJson(e as Map<String, dynamic>)).toList(),
        labelList = (json['labelList'] as List<dynamic>?)?.map((dynamic e) => DealLabelItem.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'dealMaster': dealMaster,
        'dominant': dominant,
        'lotList': lotList,
        'land': land,
        'fileList': fileList,
        'labelList': labelList,
      };

  String toString() {
    return 'DealDetailLandItem(dealMaster: $dealMaster, dominant :$dominant, lotList: $lotList, land:$land, fileList: $fileList, labelList:$labelList)';
  }
}
