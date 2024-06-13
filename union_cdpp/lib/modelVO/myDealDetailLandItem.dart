import 'package:unionCDPP/modelVO/dealLotItem.dart';
import 'package:unionCDPP/modelVO/dealNewBuildingItem.dart';
import 'package:unionCDPP/modelVO/dominantItem.dart';
import 'package:unionCDPP/modelVO/fileItem.dart';
import 'package:unionCDPP/modelVO/myDealtem.dart';

class MyDealDetailLandItem {
  int? page;
  int? rowSize;
  MyDealItem? dealMaster;
  DominantItem? dominant;
  List<DealLotItem>? lotList;
  DealNewBuildingItem? land;
  List<FileItem>? fileList;

  MyDealDetailLandItem({
    this.page,
    this.rowSize,
    this.dealMaster,
    this.dominant,
    this.lotList,
    this.land,
    this.fileList,
  });

  MyDealDetailLandItem.fromJson(Map<String, dynamic> json)
      : page = json['page'] as int?,
        rowSize = json['rowSize'] as int?,
        dealMaster = json['dealMaster'] != null ? MyDealItem.fromJson(json['dealMaster'] as Map<String, dynamic>) : null,
        dominant = json['dominant'] != null ? DominantItem.fromJson(json['dominant'] as Map<String, dynamic>) : null,
        lotList = (json['lotList'] as List<dynamic>?)?.map((dynamic e) => DealLotItem.fromJson(e as Map<String, dynamic>)).toList(),
        land = json['land'] != null ? DealNewBuildingItem.fromJson(json['land'] as Map<String, dynamic>) : null,
        fileList = (json['fileList'] as List<dynamic>?)?.map((dynamic e) => FileItem.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'page': page,
        'rowSize': rowSize,
        'dealMaster': dealMaster,
        'dominant': dominant,
        'lotList': lotList,
        'land': land,
        'fileList': fileList,
      };

  String toString() {
    return 'MyDealDetailLandItem(page:$page, rowSize:$rowSize, dealMaster: $dealMaster, dominant :$dominant, lotList: $lotList, land:$land, fileList: $fileList)';
  }
}
