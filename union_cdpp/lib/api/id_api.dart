// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/model/apiResult.dart';
import 'package:unionCDPP/modelVO/certItme.dart';
import 'package:unionCDPP/modelVO/commonCdResponse.dart';
import 'package:unionCDPP/modelVO/dealBuildingItem.dart';
import 'package:unionCDPP/modelVO/dealBuildingResponse.dart';
import 'package:unionCDPP/modelVO/dealCountItem.dart';
import 'package:unionCDPP/modelVO/dealLandItem.dart';
import 'package:unionCDPP/modelVO/dealLotItem.dart';
import 'package:unionCDPP/modelVO/dealMasterItem.dart';
import 'package:unionCDPP/modelVO/dealNewBuildingItem.dart';
import 'package:unionCDPP/modelVO/dealRegisterItem.dart';
import 'package:unionCDPP/modelVO/dealRentRollItem.dart';
import 'package:unionCDPP/modelVO/faqResponse.dart';
import 'package:unionCDPP/modelVO/memoResponse.dart';
import 'package:unionCDPP/modelVO/myAlarmResponse.dart';
import 'package:unionCDPP/modelVO/myDealDetailBuildingItem.dart';
import 'package:unionCDPP/modelVO/myDealDetailLandItem.dart';
import 'package:unionCDPP/modelVO/myDealResponse.dart';
import 'package:unionCDPP/modelVO/myInfoItem.dart';
import 'package:unionCDPP/modelVO/myInfoUpdateItem.dart';
import 'package:unionCDPP/modelVO/noticeItem.dart';
import 'package:unionCDPP/modelVO/noticeResponse.dart';
import 'package:unionCDPP/modelVO/search_option_item.dart';
import 'package:unionCDPP/modelVO/searchiInfoItem.dart';
import 'package:unionCDPP/modelVO/ssoModel.dart';

import '../common/globalvar.dart';
import '../common/utils.dart';

class IdApiPreParam {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  http.Client? client;
  Uri? uri;

  @override
  String toString() => 'IdApiPreParam(headers: $headers, client: $client, uri: $uri)';
}

class IdApi {
  //localstorage 이용해서 유저정보 보관하는방법\
  // getLastUsed와 비교해서 현재시간-마지막사용시간을 고려해서 처리한다.
  static MyInfoItem? LoggedUser() {
    MyInfoItem? login1;
    try {
      if (IdUtil.getCookie() == null) return null;
      int current = (DateTime.now().millisecondsSinceEpoch / 1000).toInt();
      int lastUsed = GV.pStrg.getLastUsed();
      ////30분을 넘어가면 로그아웃 처리
      GV.d(current,lastUsed);
      if (current - lastUsed > 1800) {
        IdUtil.logout();
        return null;
      }
      var loginStr1 = GV.pStrg.getXXX(key_gv_login);
      login1 = MyInfoItem.fromJson(jsonDecode(loginStr1));
    } catch (e) {
      print(e);
    }
    return login1;
  }

  static String _authHeader() {
    String result = '';
    MyInfoItem? login1 = GV.myInfoItem;
    if (login1 != null) result = login1.accessToken ?? '';
    return result;
  }

  static IdApiPreParam? authTokenHttp({String? url}) {
    IdApiPreParam result = IdApiPreParam();
    result.client = http.Client();
    if (url != null) {
      result.uri = Uri.parse(url);
    } else {
      return null;
    }

    var bear1 = _authHeader();
    result.headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    if (bear1.isNotEmpty) result.headers['Authorization'] = 'Bearer $bear1';
    return result;
  }

  //내정보 select
  static Future<dynamic> getMember(MyInfoItem param) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_MyInfo);
    // var headers = {'Content-Type': 'application/json'};

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: jsonEncode(param.toJson())).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          MyInfoItem data1 = MyInfoItem.fromJson(_api1.data);
          return data1;
        }
      } else {
        GV.d('Failed to load getMember');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //내정보 from SSO
  static Future<dynamic> getMember_SSO(ssoMember param) async {
    var c1 = IdApi.authTokenHttp(url: ID_SSO_URI + ID_MyInfo_SSO);

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: jsonEncode(param.toJson())).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        // GV.d(response.body);
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == '성공') {
          GV.pStrg.putLastUsed();
          ssoMember data1 = ssoMember.fromJson(_api1.data);
          return data1;
        }
      } else {
        GV.d('Failed to load getMember');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  // 이미지 로드
  static Future<Uint8List> loadImage(String imgSrc) async {
    try {
      // GV.d('imgsrc', imgSrc);
      var uri1 = Uri.parse(imgSrc);
      // GV.d('uri1', uri1);
      final res = await http.get(uri1);
      // GV.d('res', res);

      return res.bodyBytes;
    } catch (e) {
      GV.d(e);
    }
    // GV.d('end loadImage');
    return Uint8List(0);
  }

  //내정보 update
  static Future<dynamic> updateMember(MyInfoUpdateItem param, Uint8List imgData, String imgName) async {
    var dio = Dio();
    dio.options.headers = {
      Headers.contentTypeHeader: 'multipart/form-data',
    };
    var bear1 = _authHeader();
    if (bear1.isNotEmpty) dio.options.headers['Authorization'] = 'Bearer $bear1';

    var formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(imgData, filename: imgName, contentType: MediaType.parse('multipart/form-data')),
      'userInfo': MultipartFile.fromString(jsonEncode(param), contentType: MediaType.parse('application/json'))
    });

    try {
      final response = await dio.post(ID_BASE_URI + ID_MyInfo_Update, data: formData);
      if (response != null && response.statusCode == 200) {
        if (response.data['message'] == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          return 'SUCCESS';
        } else {
          GV.d('Failed to load updateMember');
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //내 딜 카운트
  static Future<dynamic> getDealCount(String userNo) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_MyDeal_Count);
    // var headers = {'Content-Type': 'application/json'};
    var userParam = '"userNo": "$userNo"';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: '{$userParam}').timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          DealCountItem data1 = DealCountItem.fromJson(_api1.data);
          return data1;
        } else {
          GV.d('Failed to load getDealCount');
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //마이 딜
  static Future<dynamic> getMydael(String userNo, SearchOptionItme param1, SearchInfoItem param2) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_MyDeal);
    // var headers = {'Content-Type': 'application/json'};
    var userParam = '"userNo": "$userNo"';
    var pageParam = '"commonInfo": ${jsonEncode(param1.toJson())}';
    var searchParam = '"searchInfo": ${jsonEncode(param2.toJson())}';

    try {
      final response = await c1?.client!
          .post(c1.uri!, headers: c1.headers, body: '{$userParam, $pageParam, $searchParam}')
          .timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          MyDealResponse data1 = MyDealResponse.fromJson(_api1.data);

          return data1;
        } else {
          GV.d('Failed to load getMydeal');
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //마이 딜 상세
  static Future<dynamic> getMydaelDetail(String userNo, String dealNo, String type) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_MyDeal_Detail);
    // var headers = {'Content-Type': 'application/json'};
    var body = '{"userNo":"$userNo", "dealNo":"$dealNo","type":"$type"}';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == "SUCCESS") {
          GV.pStrg.putLastUsed();
          if (type == 'L') {
            MyDealDetailLandItem data1 = MyDealDetailLandItem.fromJson(_api1.data);
            return data1;
          } else {
            MyDealDetailBuildingItem data1 = MyDealDetailBuildingItem.fromJson(_api1.data);
            return data1;
          }
        } else {
          GV.d('Failed to load getMydealDetail');
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //마이 딜 상세 메모
  static Future<dynamic> getMemo(String dealNo, SearchOptionItme param) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_MyDeal_MemoList);
    // var headers = {'Content-Type': 'application/json'};
    var dealParam = '"dealNo": $dealNo';
    var pageParam = '"commonInfo": ${jsonEncode(param.toJson())}';
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: '{$dealParam, $pageParam}').timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          MemoResponse data1 = MemoResponse.fromJson(_api1.data);
          return data1;
        } else {
          GV.d('Failed to load getMemo');
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //메모 등록
  static Future<dynamic> setDealMemo(String dealNo, String userNo, String memo, Uint8List imgData, String imgName) async {
    var dio = Dio();
    dio.options.headers = {
      Headers.wwwAuthenticateHeader: '',
      Headers.contentTypeHeader: 'multipart/form-data',
    };
    var bear1 = _authHeader();
    if (bear1.isNotEmpty) dio.options.headers['Authorization'] = 'Bearer $bear1';

    var param = '{"dealNo":"$dealNo","userNo":"$userNo","memo":"$memo"}';

    var formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(imgData, filename: imgName, contentType: MediaType.parse('multipart/form-data')),
      'memoInfo': MultipartFile.fromString(param, contentType: MediaType.parse('application/json'))
    });

    try {
      final response = await dio.post(ID_BASE_URI + ID_MyDeal_Register_Memo, data: formData);

      if (response != null && response.statusCode == 200) {
        if (response.data['message'] == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          return 'SUCCESS';
        }
      } else {
        GV.d('Failed to load setDeamMemo');
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //마이 알림
  static Future<dynamic> getMyalarm(String userNo, SearchOptionItme param) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_MyAlarm);
    // var headers = {'Content-Type': 'application/json'};
    var userParam = '"userNo": $userNo';
    var pageParam = '"commonInfo": ${jsonEncode(param.toJson())}';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: '{$userParam, $pageParam}').timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          MyAlarmResponse data1 = MyAlarmResponse.fromJson(_api1.data);
          return data1;
        } else {
          GV.d('Failed to load getMyalarm');
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //마이 알림 읽음 표시 변경
  static Future<dynamic> updateMyalarm(String userNo, String dealLogNo) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_MyAlarmCheck);
    // var headers = {'Content-Type': 'application/json'};
    var body = '{"userNo": "$userNo", "dealLogNo": "$dealLogNo"}';
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api = ApiResult.fromJson(item1);
        if (_api.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          return _api.data;
        } else {
          GV.d('Failed to load updateMyalarm');
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //딜NO 생성
  static Future<dynamic> setDealNo() async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_DealNo);
    // var headers = {'Content-Type': 'application/json'};

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: '').timeout(Duration(seconds: 5));
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = json.decode(response.body);
        var _api = ApiResult.fromJson(item1);
        if (_api.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          return _api.data;
        } else {
          GV.d('Failed to load setDealNo');
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

//공통코드1
  static Future<dynamic> getCommonCd1() async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_Location_Detail);
    // var headers = {'Content-Type': 'application/json'};

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: '').timeout(Duration(seconds: 5));
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          CommonCdResponse data1 = CommonCdResponse.fromJson(_api1.data);
          return data1;
        } else {
          GV.d('Failed to load getComonCd1');
        }
      }
    } catch (e) {
      print(e);
    }
  }

//공통코드1
  static Future<dynamic> getCommonCd2() async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_Item_Detail);
    // var headers = {'Content-Type': 'application/json'};

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: '').timeout(Duration(seconds: 5));
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          CommonCdResponse data1 = CommonCdResponse.fromJson(_api1.data);
          return data1;
        } else {
          GV.d('Failed to load getCommonCd2');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //딜 대지 정보(외부 API)
  static Future<dynamic> getLandInfo(String jibunAddress) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_Deal_landInfo);
    // var headers = {'Content-Type': 'application/json'};
    var body = '{"jibunAddress": "$jibunAddress"}';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 15));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          DealLandItem data1 = DealLandItem.fromJson(_api1.data);
          return data1;
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //딜 건물 정보(외부 API)
  static Future<dynamic> getBuildingInfo(String jibunAddress) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_Deal_buildingInfo);
    // var headers = {'Content-Type': 'application/json'};
    var body = '{"jibunAddress": "$jibunAddress"}';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 15));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          DealBuildingResponse data1 = DealBuildingResponse.fromJson(_api1.data);
          return data1;
        }
      } else {
        GV.d('Failed to load getBuildingInfo');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //임시 파일 업로드
  static Future<dynamic> uploadTempFile(Uint8List imgData, String userNo, String fileDoc, String fileOrder, String dealNo) async {
    Map<String, String> i1 = {'userNo': userNo, 'dealNo': dealNo, 'fileOrder': fileOrder, 'fileDoc': fileDoc};
    print(i1);
    var dio = Dio();
    dio.options.headers = {
      Headers.contentTypeHeader: 'multipart/form-data',
    };
    var bear1 = _authHeader();
    if (bear1.isNotEmpty) dio.options.headers['Authorization'] = 'Bearer $bear1';

    var formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(imgData, filename: fileDoc, contentType: MediaType.parse('multipart/form-data')),
      'metaData': MultipartFile.fromString(jsonEncode(i1), contentType: MediaType.parse('application/json'))
    });

    try {
      //  var request = http.MultipartRequest('POST', Uri.parse(ID_BASE_URI + ID_FileUpload));
      final response = await dio.post(ID_BASE_URI + ID_FileUpload, data: formData);
      if (response != null && response.statusCode == 200) {
        if (response.data['message'] == 'SUCCESS') {
          return 'SUCCESS';
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //임시 파일 업데이트
  static Future<dynamic> updatgeTempFile(Uint8List imgData, String userNo, String fileDoc, String fileOrder, String dealNo) async {
    Map<String, String> i1 = {'userNo': userNo, 'dealNo': dealNo, 'fileOrder': fileOrder, 'fileDoc': fileDoc};
    print(i1);
    var dio = Dio();
    dio.options.headers = {
      Headers.contentTypeHeader: 'multipart/form-data',
    };
    var bear1 = _authHeader();
    if (bear1.isNotEmpty) dio.options.headers['Authorization'] = 'Bearer $bear1';

    var formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(imgData, filename: fileDoc, contentType: MediaType.parse('multipart/form-data')),
      'metaData': MultipartFile.fromString(jsonEncode(i1), contentType: MediaType.parse('application/json'))
    });

    try {
      //  var request = http.MultipartRequest('POST', Uri.parse(ID_BASE_URI + ID_FileUpload));
      final response = await dio.post(ID_BASE_URI + ID_FileUpdate, data: formData);

      if (response != null && response.statusCode == 200) {
        if (response.data['message'] == 'SUCCESS') {
          return 'SUCCESS';
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //딜 등록 부지
  static Future<dynamic> setDealLand(String dealNo, String userNo, String pnu, DealMasterItem dealMasterItem,
      DealNewBuildingItem dealNewBuildingItem, List<DealLotItem> dealLotList, List<dynamic> fileItemList) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_Deal_register);
    // var headers = {'Content-Type': 'application/json'};
    var body =
        '{"common":{"dealNo":"$dealNo","userNo":"$userNo","pnu":"$pnu"}, "dealMaster":${jsonEncode(dealMasterItem.toJson())}, "land":${jsonEncode(dealNewBuildingItem.toJson())}, "lotList":$dealLotList, "fileInfoList":$fileItemList}';
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = json.decode(response.body);
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          DealRegisterItem data1 = DealRegisterItem.fromJson(_api1.data);
          return data1;
        } else {
          GV.d('Faild to load');
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //딜 등록 건물
  static Future<dynamic> setDealBuilding(String dealNo, String userNo, String pnu, DealMasterItem dealMasterItem,
      DealBuildingItem dealBuildingItem, List<DealRentRollItem> dealRentRollList, List<dynamic> fileItemList) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_Deal_register);
    // var headers = {'Content-Type': 'application/json'};
    var body =
        '{"common":{"dealNo":"$dealNo","userNo":"$userNo","pnu":"$pnu"}, "dealMaster":${jsonEncode(dealMasterItem.toJson())},  "building":${jsonEncode(dealBuildingItem.toJson())}, "rentrollList":$dealRentRollList, "fileInfoList":$fileItemList}';
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          DealRegisterItem data1 = DealRegisterItem.fromJson(_api1.data);
          return data1;
        } else {
          GV.d('Faild to load');
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //딜 수정 부지
  static Future<dynamic> updateDealLand(String dealNo, String userNo, String pnu, DealMasterItem dealMasterItem,
      DealNewBuildingItem dealNewBuildingItem, List<dynamic> dealLotList, List<dynamic> fileItemList) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_Deal_update);
    // var headers = {'Content-Type': 'application/json'};
    var body =
        '{"common":{"dealNo":"$dealNo","userNo":"$userNo","pnu":"$pnu"}, "dealMaster":${jsonEncode(dealMasterItem.toJson())}, "land":${jsonEncode(dealNewBuildingItem.toJson())}, "lotList":${jsonEncode(dealLotList)}, "fileInfoList":$fileItemList}';
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = json.decode(response.body);
        var _api1 = ApiResult.fromJson(item1);
        print(_api1);
        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          return _api1;
        } else {
          GV.d('Faild to load');
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //딜 수정 건물
  static Future<dynamic> updatDealBuilding(String dealNo, String userNo, String pnu, DealMasterItem dealMasterItem,
      DealBuildingItem dealBuildingItem, List<dynamic> dealRentRollList, List<dynamic> fileItemList) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_Deal_update);
    // var headers = {'Content-Type': 'application/json'};
    var body =
        '{"common":{"dealNo":"$dealNo","userNo":"$userNo","pnu":"$pnu"}, "dealMaster":${jsonEncode(dealMasterItem.toJson())},  "building":${jsonEncode(dealBuildingItem.toJson())}, "rentrollList":${jsonEncode(dealRentRollList)}, "fileInfoList":$fileItemList}';
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          return _api1;
        } else {
          GV.d('Faild to load');
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //독점등록
  static Future<dynamic> setApplyDomi(String dealNo, String userNo) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_Apply_Domi);
    // var headers = {'Content-Type': 'application/json'};
    var body = '{"dealNo": "$dealNo","userNo": "$userNo"}';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));
      if (response != null) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          return _api1.data;
        } else {
          GV.d('Failed to load setApplyDomi');
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //공지사항
  static Future<dynamic> getNotice(SearchOptionItme param) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_NoticeList);
    // var headers = {'Content-Type': 'application/json'};
    var body = '{"commonInfo": ${jsonEncode(param.toJson())}}';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          NoticeResponse data1 = NoticeResponse.fromJson(_api1.data);
          return data1;
        }
      } else {
        GV.d('Failed to load getNotice');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //공지사항 상세
  static Future<dynamic> getNoticeDetail(String noticeNo) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_NoticeDetail);
    var body = '{"noticeNo" : "$noticeNo"}';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));

      if (response != null || response!.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          NoticeItem data1 = NoticeItem.fromJson(_api1.data);
          return data1;
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //FAQ
  static Future<dynamic> getFaq(SearchOptionItme param) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_FaqList);
//    var headers = {'Content-Type': 'application/json'};
    var body = '{"commonInfo": ${jsonEncode(param.toJson())}}';
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          FaqResponse data1 = FaqResponse.fromJson(_api1.data);
          return data1;
        }
      } else {
        GV.d('Failed to load getFaq');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //독점보호 인증서
  static Future<dynamic> getCert(String dealNo) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_Cert);
    var body = '{"dealNo": "$dealNo"}';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          CertItem data1 = CertItem.fromJson(_api1.data);
          return data1;
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  // 로그인 점검용 - 로직점검용
  static Future<dynamic> loginCheck(String bid) async {
    var client = http.Client();
    var uri = Uri.parse(ID_BASE_URI + ID_LoginCheck);
    var headers = {'Content-Type': 'application/json'};

    try {
      final response = await client!.post(uri, headers: headers, body: '{"bid":"$bid"}').timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          GV.pStrg.putXXX(key_gv_login, jsonEncode(_api1.data));
          MyInfoItem data1 = MyInfoItem.fromJson(_api1.data);
          GV.myInfoItem = data1;
          IdUtil.setCookie(GV.myInfoItem.accessToken!);
          // IdUtil.getCookie();

          return data1;
        }
      } else {
        // GV.d('Failed to load logincheck $bid');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //sso password변경
  static Future<bool> changePassoword_SSO(String uid, String cpwd, String npwd) async {
    var c1 = IdApi.authTokenHttp(url: ID_SSO_URI + ID_ChangePwd_SSO);
    var bodyStr = '{"uIdx": "$uid","currentPassword": "$cpwd","newPassword": "$npwd"}';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: bodyStr).timeout(Duration(seconds: 5));
      print(c1);
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        print(_api1);
        if (_api1.serviceCode == 'SUCCESS') {
          GV.pStrg.putLastUsed();
          return true;
        }
      } else {
        GV.d('Failed to load changePassoword_SSO');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  //내정보 update
  static Future<dynamic> updateMember_SSO(MyInfoUpdateItem param, Uint8List? imgData, String? imgName) async {
    var dio = Dio();
    dio.options.headers = {
      Headers.contentTypeHeader: 'multipart/form-data',
    };
    var bear1 = _authHeader();
    if (bear1.isNotEmpty) dio.options.headers['Authorization'] = 'Bearer $bear1';

    FormData formData;

    if (imgData != null) {
      formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(imgData, filename: imgName, contentType: MediaType.parse('multipart/form-data')),
        'userInfo': MultipartFile.fromString(jsonEncode(param), contentType: MediaType.parse('application/json'))
      });
    } else {
      formData =
          FormData.fromMap({'userInfo': MultipartFile.fromString(jsonEncode(param), contentType: MediaType.parse('application/json'))});
    }

    try {
      final response = await dio.post(ID_SSO_URI + ID_MyInfo_Update_SSO, data: formData);
      print(response);
      if (response != null && response.statusCode == 200) {
        if (response.data['message'] == '성공') {
          GV.pStrg.putLastUsed();
          return 'SUCCESS';
        } else {
          GV.d('Failed to load updateMember');
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //phone 인증 코드 요구
  static Future<String> requestSmsCode_SSO(String phone) async {
    var c1 = IdApi.authTokenHttp(url: ID_SSO_URI + ID_RequestSmsCode_SSO);
    var bodyStr = '{"target": "$phone"}';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: bodyStr).timeout(Duration(seconds: 5));
      print(c1);
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        print(_api1);
        if (_api1.message == '성공') {
          return _api1.data;
        }
      } else {
        GV.d('Failed to load requestSmsCode_SSO');
      }
    } catch (e) {
      print(e);
    }
    return '';
  }

  static Future<dynamic> getS3FileContent(String s3url) async {
    var client = http.Client();

    var uri = Uri.parse(s3url);

    try {
      final response = await client.get(uri, headers: {'Content-Type': 'application/octet-stream'}).timeout(Duration(seconds: 5));

      if (response != null) {
        Uint8List bodyBytes = response.bodyBytes;
        if (response.statusCode == 200 && bodyBytes.isNotEmpty) {
          return response.bodyBytes;
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
