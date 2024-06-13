// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:union_admin/constants/constants.dart';
import 'package:union_admin/model/apiResult.dart';
import 'package:union_admin/modelVO/certItme.dart';
import 'package:union_admin/modelVO/dealDetailBuildingItem.dart';
import 'package:union_admin/modelVO/dealDetailLandItem.dart';
import 'package:union_admin/modelVO/dealDomiResponse.dart';
import 'package:union_admin/modelVO/dealResponse.dart';
import 'package:union_admin/modelVO/dealStatusResponse.dart';
import 'package:union_admin/modelVO/labelResponse.dart';
import 'package:union_admin/modelVO/locationResponse.dart';
import 'package:union_admin/modelVO/memoResponse.dart';
import 'package:union_admin/modelVO/myInfoItem.dart';
import 'package:union_admin/modelVO/progressResponse.dart';
import 'package:union_admin/modelVO/search_option_item.dart';

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
  //localstorage 이용해서 유저정보 보관하는방법
  static MyInfoItem? LoggedUser() {
    MyInfoItem? login1;
    try {
      if (IdUtil.getCookie() == null) return null;
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

  // 이미지 로드
  static Future<Uint8List> loadImage(String imgSrc) async {
    try {
      GV.d('imgsrc', imgSrc);
      var uri1 = Uri.parse(imgSrc);
      GV.d('uri1', uri1);
      final res = await http.get(uri1);
      GV.d('res', res);

      return res.bodyBytes;
    } catch (e) {
      GV.d(e);
    }
    GV.d('end loadImage');
    return Uint8List(0);
  }

  //독점딜 리스트
  static Future<dynamic> getdealDomiList(SearchOptionItme param) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_DealDomi);

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: jsonEncode(param.toJson())).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          DealDomiResponse data1 = DealDomiResponse.fromJson(_api1.data);
          return data1;
        } else {
          GV.d('Failed to load getNotice');
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //딜 진행사항 리스트
  static Future<dynamic> getDealList(SearchOptionItme param) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_Deal);
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: jsonEncode(param.toJson())).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          DealResponse data1 = DealResponse.fromJson(_api1.data);
          return data1;
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //딜 디테일
  static Future<dynamic> getDealDetail(String dealNo, String type) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_DealDetail);
    var dealParam = '"dealNo": "$dealNo"';
    var typeParam = '"type": "$type"';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: '{$dealParam, $typeParam}').timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          if (type == 'B') {
            DealDetailBuildingItem data1 = DealDetailBuildingItem.fromJson(_api1.data);
            return data1;
          } else {
            DealDetailLandItem data1 = DealDetailLandItem.fromJson(_api1.data);
            return data1;
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// type을 넣지않고 처리하는데 deal타입을 알수 없으니, 적절한 처리가 필요하다.
  static Future<dynamic> getDealDetail2(String dealNo) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_DealDetail);
    var dealParam = '"dealNo": "$dealNo"';
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: '{$dealParam}').timeout(Duration(seconds: 20));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          if (_api1.data['dealMaster']['type'] == 'B') {
            DealDetailBuildingItem data1 = DealDetailBuildingItem.fromJson(_api1.data);
            return data1;
          } else {
            DealDetailLandItem data1 = DealDetailLandItem.fromJson(_api1.data);
            return data1;
          }
        }
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
          CertItem data1 = CertItem.fromJson(_api1.data);
          return data1;
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //메모리스트
  static Future<dynamic> getMemoList(SearchOptionItme param) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_Memo);

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: jsonEncode(param.toJson())).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          MemoResponse data1 = MemoResponse.fromJson(_api1.data);
          return data1;
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //독정승인
  static Future<dynamic> setDomi(List<String> domiNoList, String userNo) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_DealDomiUpdate);
    var body = '{"domiNoList": $domiNoList, "userNo": "$userNo" }';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));
      if (response != null) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          return _api1.message;
        } else {
          GV.d('Failed to load setApplyDomi');
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //메모 등록
  static Future<dynamic> setMemo(String dealNo, String userNo, String memo, Uint8List imgData, String imgName) async {
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
      final response = await dio.post(ID_BASE_URI + ID_MemoRegist, data: formData);

      if (response != null && response.statusCode == 200) {
        if (response.data['message'] == 'SUCCESS') {
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

//진행상태 변경 이력
  static Future<dynamic> getStatusHistory(SearchOptionItme param) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_StatusHistory);

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: jsonEncode(param.toJson())).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          DealStatusResponse data1 = DealStatusResponse.fromJson(_api1.data);
          return data1;
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //라벨리스트
  static Future<dynamic> getLabelList(SearchOptionItme param) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_LableList);

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: jsonEncode(param.toJson())).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          LabelResponse data1 = LabelResponse.fromJson(_api1.data);
          return data1;
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //라벨 편집
  static Future<dynamic> setLabel(String userNo, String dealNo, List dealLabelNoList) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_LableEdit);
    var body = '{"dealNo": "$dealNo", "userNo": "$userNo", "dealLabelNoList": $dealLabelNoList}';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));

      if (response != null) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          return _api1.message;
        } else {
          GV.d('Failed to load setApplyDomi');
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //진행상태 공통코드
  static Future<dynamic> getProgressCd() async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_ProgressCd);
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          ProgressResponse data1 = ProgressResponse.fromJson(_api1.data);
          return data1;
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //위치 특이사항 코드
  static Future<dynamic> getAdditionCd() async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_AdditionCd);
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers).timeout(Duration(seconds: 5));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);

        if (_api1.message == 'SUCCESS') {
          LocationResponse data1 = LocationResponse.fromJson(_api1.data);
          return data1;
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

// TODO 화면상의 데이터와 서버에서 주는 데이터가 달라, 추후 자체적으로 해결하는 방법으로 가야될것 같음.
  //엑셀-독점
  static Future<dynamic> setDomiExcell(SearchOptionItme param) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_DomiExcel);
    try {
      final response = await c1?.client!.get(c1.uri!, headers: c1.headers).timeout(Duration(seconds: 5));

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

//TODO 엑셀 다시 보기
  //엑셀-딜
  static Future<dynamic> setDealExcell(SearchOptionItme param) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_DealExcel);
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: jsonEncode(param.toJson())).timeout(Duration(seconds: 5));

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

  //진행상태 수정
  static Future<dynamic> setStatus(String userNo, String dealNo, String title, String etc) async {
    var c1 = IdApi.authTokenHttp(url: ID_BASE_URI + ID_ProgressUpdate);
    var body = '{"userNo": "$userNo", "dealNo": "$dealNo", "title": "$title", "etc": "$etc"}';

    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: body).timeout(Duration(seconds: 5));

      if (response != null) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        if (_api1.message == 'SUCCESS') {
          return _api1.message;
        } else {
          GV.d('Failed to load setApplyDomi');
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
