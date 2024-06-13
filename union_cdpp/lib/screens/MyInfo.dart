import 'dart:convert';
import 'dart:typed_data';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:croppy/croppy.dart';
import 'package:flutter/material.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/common/utils.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdImageBox2.dart';
import 'package:unionCDPP/id_widget/IdInfoFormat.dart';
import 'package:unionCDPP/id_widget/IdInputValidation.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageTopSection.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdSubNavigator.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';
import 'package:unionCDPP/id_widget/KakaoAddress/kakao_address_widget.dart';
import 'package:unionCDPP/modelVO/myInfoItem.dart';
import 'package:unionCDPP/modelVO/myInfoUpdateItem.dart';
import 'package:file_picker/file_picker.dart';
import 'package:unionCDPP/modelVO/ssoModel.dart';
import 'package:unionCDPP/popup/addressPopup.dart';
import 'package:web_socket_client/web_socket_client.dart';

import '../id_widget/IdTopToast.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({super.key});

  @override
  IdState<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends IdState<MyInfo> {
  List menuNavigator = [];
  List menuNavigatorLink = [];
  List submenuNameList = [];
  List submenuNavigatorLink = [];
  String userNo = '';
  String userName = '';
  String registDateTime = '';
  String approveDateTime = '';
  String userId = '';
  String userPw = '';
  String userEmail = '';
  String userPhone = '';
  String userOrg = '';
  String userType = '';
  int grade = 0;
  String office = '';
  String officeAddr = '';
  String officeAddrDetail = '';
  String ncardPath = '';
  String ncardName = '';
  String s3FileUrl = '';
  int ncardChekInt = 0;

  Uint8List? nameCardImg;

  bool emailInputCheck = false;

  Image? uploadImg1;
  RawImage? uploadRawImg;

  bool addressPopupVisible = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _phoneCertController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _companyAddressController = TextEditingController();
  TextEditingController _companyDetailAddressController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _userPwController1 = TextEditingController();
  TextEditingController _userPwController2 = TextEditingController();
  CountDownController _countDownController = CountDownController();

  bool phoneVerified = false;
  bool certificationPopup = false;
  String phoneCode = '';

  WebSocket? socket;

  @override
  void dispose() {
    socket?.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userNo = GV.pStrg.getXXX(Param_commonUserNo);

    menuNavigator = ['home', 'My Page', '내 정보'];
    menuNavigatorLink = [
      () {
        uiCommon.IdMovePage(context, PAGE_MYINFO_PAGE);
      },
      () {
        uiCommon.IdMovePage(context, PAGE_MYINFO_PAGE);
      }
    ];
    submenuNameList = ['내 정보', '내가 등록한 딜', '알림'];
    submenuNavigatorLink = [
      () {
        uiCommon.IdMovePage(context, PAGE_MYINFO_PAGE);
      },
      () {
        uiCommon.IdMovePage(context, PAGE_MYDEAL_PAGE);
      },
      () {
        uiCommon.IdMovePage(context, PAGE_MYALARM_PAGE);
      }
    ];

    Future.delayed(Duration(milliseconds: 10), () async {
      String uuidStr = GV.pStrg.getXXX(key_gv_uuid);
      socket = WebSocket(
        Uri.parse(ID_WEB_URI),
        backoff: ConstantBackoff(Duration(seconds: 1)),
        timeout: const Duration(seconds: 5),
      );
      socket?.messages.listen((event) {
        if (event.toString().isNotEmpty) {
          var jmap = jsonDecode(utf8.decode(utf8.encode(event.toString())));
          GV.pStrg.putXXX(key_gv_login, jsonEncode(jmap));
          MyInfoItem data1 = MyInfoItem.fromJson(jmap);
          GV.myInfoItem = data1;
          IdUtil.setCookie(GV.myInfoItem.accessToken!);
          // IdUtil.getCookie();
          uiCommon.IdMovePage(context, PAGE_MYINFO_PAGE);
        }
      });
      await socket?.connection.firstWhere((state) => state is Connected);
      socket?.send('hi123907812|bid|$uuidStr|org|cdpp');

      fetchData();
    });
  }

  Future<void> fetchData() async {
    final dynamic ret1 = await IdApi.getMember_SSO(ssoMember(uIdx: userNo));
    if (ret1 != null) {
      ssoMember? ssoUser = ret1;
      MyInfoItem? data = IdApi.LoggedUser();
      if (data != null && ssoUser != null) {
        data.s3FileUrl = ssoUser.s3FileUrl;
        data.ncardUrl = ssoUser.s3FileUrl;
        // data.userName=ssoUser.uName;
        // data.grade = ssoUser.uGrade;

        userName = data.userName!;
        grade = int.tryParse(data.grade!) ?? 1;
        registDateTime = data.createDate!;
        if (data.regularDate == null) {
          approveDateTime = '';
        } else {
          approveDateTime = data.regularDate!;
        }
        userEmail = data.userEmail!;
        userPhone = data.userTel!;
        office = data.office!;
        officeAddr = data.officeAddr!;
        if (data.officeAddrDetail != null) {
          officeAddrDetail = data.officeAddrDetail!;
        } else {
          officeAddrDetail = '';
        }
        userId = data.userId!;
        if (data.ncardUrl == null) {
          ncardPath = '';
          ncardChekInt = 0;
        } else {
          ncardPath = data.ncardUrl!;
          ncardChekInt = 1;
        }
        if (data.ncardName == null) {
          ncardName = '';
        } else {
          ncardName = data.ncardName!;
        }
        if (data.ncardUrl == null) {
          s3FileUrl = '';
        } else {
          s3FileUrl = data.ncardUrl!;
        }
        setState(() {});
      }
    }
  }

  Future<bool> setMember() async {
    if (_emailController.text.isNotEmpty) {
      userEmail = _emailController.text;
    }
    if (_phoneController.text.isNotEmpty) {
      userPhone = _phoneController.text;
    }
    if (_companyController.text.isNotEmpty) {
      office = _companyController.text;
    }
    if (_companyAddressController.text.isNotEmpty) {
      officeAddr = _companyAddressController.text;
    }
    if (_companyDetailAddressController.text.isNotEmpty) {
      officeAddrDetail = _companyDetailAddressController.text;
    }

    var uuidStr = GV.pStrg.getXXX(key_gv_uuid);

    MyInfoUpdateItem param = MyInfoUpdateItem(
      uIdx: GV.pStrg.getXXX(Param_commonUserNo),
      uId: userId,
      uEmail: userEmail,
      uPhone: userPhone,
      uDepartment: office,
      uOfficeAddr: officeAddr,
      uOfficeAddrDetail: officeAddrDetail,
      callBackUrl: '$ID_BASE_URI/internal/login-callback?bid=$uuidStr&org=cdpp',
    );
    try {
      print(param);
      final result = await IdApi.updateMember_SSO(param, nameCardImg, ncardName);
      if (result == null) return false;
      print(result);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  String obscureText(String userPw) {
    String result = '';
    result = (('*') * userPw.length).toString();
    return result;
  }

  Widget bottomBtn(String btnString, Color btnColor, double btnWidth, Color btnTextColor, Function() onBtnPressed) {
    return IdNormalBtn(
      onBtnPressed: onBtnPressed,
      childWidget: Container(
        width: btnWidth,
        height: 57,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: uiCommon.styledText(btnString, 18, 0, 1.6, FontWeight.w700, btnTextColor, TextAlign.left),
        ),
      ),
    );
  }

  String userGradeStr(int grade) {
    String result = '';
    if (grade == 1) {
      result = '일반회원';
    } else if (grade == 2) {
      result = '정회원';
    } else if (grade == 3) {
      result = '준회원';
    } else {
      result = '';
    }
    return result;
  }

  // 1개의 파일 업로드
  Future<void> uploadFile() async {
    // file picker를 통해 파일 선택
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = '${result.files.first.name.split('.')[0]}.jpg';
      // final filePath = result.files.first.path;

      ncardName = fileName;
      ncardChekInt = 1;
      setState(() {});

      // 파일 경로를 통해 formData 생성
      //  var dio = Dio();

      //  var formData = FormData.fromMap({'file':MultipartFile.fromBytes(fileBytes as List<int>)});// await MultipartFile.fromFile(filePath!)});
      uploadImg1 = Image.memory(
        fileBytes as Uint8List,
        width: 520,
        height: 289,
        fit: BoxFit.contain,
        alignment: Alignment.center,
      );

      // ignore: use_build_context_synchronously
      showCupertinoImageCropper(context,
          imageProvider: uploadImg1!.image,
          cropPathFn: aabbCropShapeFn,
          enabledTransformations: Transformation.values,
          shouldPopAfterCrop: true,
          allowedAspectRatios: [const CropAspectRatio(width: 520, height: 289)], postProcessFn: (result) async {
        var croppedImg1 = RawImage(image: result.uiImage);

        var toJpg = await uiCommon.convertImageToJpg(result.uiImage);

        nameCardImg = toJpg;

        uploadRawImg = croppedImg1;
        setState(() {});
        return result;
      });

      // 업로드 요청
      // final response = await dio.post('/upload', data: formData);
    } else {
      // 아무런 파일도 선택되지 않음.
    }
  }

  @override
  Widget idBuild(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          uiCommon.IdMovePage(context, '{PREV}');
          return false;
        },
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const IdSpace(spaceWidth: 0, spaceHeight: 74),
                      //상단
                      idTopContent1(
                          IdColors.green2,
                          menuNavigator,
                          menuNavigatorLink,
                          '마이페이지',
                          'My Page',
                          '내 정보',
                          const IdImageBox(
                              imagePath: 'assets/img/img_myInfo.png', imageWidth: 420, imageHeight: 299.19, imageFit: BoxFit.cover),
                          submenuNameList,
                          submenuNavigatorLink),
                      //섹션
                      Container(
                        width: double.infinity,
                        color: IdColors.white,
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 1224),
                            child: Column(
                              children: [
                                const IdSpace(spaceWidth: 0, spaceHeight: 120),
                                //섹션 타이틀
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      uiCommon.styledText('내 정보', 32, 0, 1.3, FontWeight.w700, IdColors.textDefault, TextAlign.left),
                                    ],
                                  ),
                                ),
                                const IdSpace(spaceWidth: 0, spaceHeight: 24),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //좌측 정보쓰는 곳
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        IdInfoFormat(
                                          formatTitle: '이름',
                                          formatContent: uiCommon.styledText(
                                              userName, 15, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                        ),
                                        const IdSpace(spaceWidth: 0, spaceHeight: 20),
                                        IdInfoFormat(
                                          formatTitle: '회원구분',
                                          formatContent: Container(
                                            height: 26,
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                            decoration: ShapeDecoration(
                                              color: IdColors.textDefault,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                            ),
                                            child: Row(
                                              children: [
                                                const IdImageBox(
                                                    imagePath: 'assets/img/icon_user.png',
                                                    imageWidth: 14,
                                                    imageHeight: 14,
                                                    imageFit: BoxFit.cover),
                                                const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                                uiCommon.styledText(userGradeStr(grade), 14, 0, 1, FontWeight.w500,
                                                    IdColors.backgroundDefault, TextAlign.left),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const IdSpace(spaceWidth: 0, spaceHeight: 20),
                                        IdInfoFormat(
                                          formatTitle: '가입/승인일시',
                                          formatContent: uiCommon.styledText('$registDateTime / $approveDateTime', 15, 0, 1.6,
                                              FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                        ),
                                        const IdSpace(spaceWidth: 0, spaceHeight: 20),
                                        IdInfoFormat(
                                          formatTitle: 'E-mail',
                                          formatContent: IdInputValidation(
                                            width: 406,
                                            height: 44,
                                            inputColor: IdColors.backgroundDefault,
                                            round: 8,
                                            controller: _emailController,
                                            textAlign: 'start',
                                            hintText: userEmail,
                                            hintTextFontSize: 16,
                                            hintTextfontWeight: FontWeight.w400,
                                            hintTextFontColor: IdColors.textTertiary,
                                            keyboardType: 'text',
                                            validationText: '',
                                            validationVisible: false,
                                            vlaidationCheck: false,
                                            enabledBool: true,
                                          ),
                                        ),
                                        const IdSpace(spaceWidth: 0, spaceHeight: 20),
                                        IdInfoFormat(
                                          formatTitle: '휴대전화번호',
                                          formatContent: Row(
                                            children: [
                                              IdInputValidation(
                                                width: 298,
                                                height: 44,
                                                inputColor: IdColors.backgroundDefault,
                                                round: 8,
                                                controller: _phoneController,
                                                textAlign: 'start',
                                                hintText: userPhone,
                                                hintTextFontSize: 16,
                                                hintTextfontWeight: FontWeight.w400,
                                                hintTextFontColor: IdColors.textTertiary,
                                                keyboardType: 'text',
                                                validationText: '',
                                                validationVisible: false,
                                                vlaidationCheck: false,
                                                enabledBool: !phoneVerified,
                                              ),
                                              const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                              IdNormalBtn(
                                                onBtnPressed: () async {
                                                  if (phoneVerified) {
                                                    activeToast('휴대전화번호 검증이 완료되었습니다.');
                                                    return;
                                                  }
                                                  if (_phoneController.text.length == 11 && _phoneController.text.startsWith('010')) {
                                                    var data = await IdApi.requestSmsCode_SSO(_phoneController.text);
                                                    if (data.length > 0) {
                                                      certificationPopup = true;
                                                      phoneCode = data;
                                                      setState(() {});
                                                    }
                                                  } else {
                                                    activeToast('휴대전화번호 입력을 확인해주세요.');
                                                  }
                                                },
                                                childWidget: Container(
                                                  width: 100,
                                                  height: 44,
                                                  decoration: BoxDecoration(
                                                    color: IdColors.textDefault,
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Center(
                                                    child: uiCommon.styledText(
                                                        '본인인증', 15, 0, 1.6, FontWeight.w600, IdColors.white, TextAlign.left),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ///////////////// 폰인증입력 start
                                        Visibility(visible: certificationPopup, child: const IdSpace(spaceWidth: 0, spaceHeight: 20)),
                                        Visibility(
                                            visible: certificationPopup,
                                            child: IdInfoFormat(
                                              formatTitle: '인증번호',
                                              formatContent: Row(
                                                children: [
                                                  IdInputValidation(
                                                    width: 298,
                                                    height: 44,
                                                    inputColor: IdColors.backgroundDefault,
                                                    round: 8,
                                                    controller: _phoneCertController,
                                                    textAlign: 'start',
                                                    hintText: '',
                                                    hintTextFontSize: 16,
                                                    hintTextfontWeight: FontWeight.w400,
                                                    hintTextFontColor: IdColors.textTertiary,
                                                    keyboardType: 'text',
                                                    validationText: '',
                                                    validationVisible: false,
                                                    vlaidationCheck: false,
                                                    enabledBool: true,
                                                  ),
                                                  const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                  IdNormalBtn(
                                                    onBtnPressed: () async {
                                                      if (phoneCode.isEmpty ||
                                                          _phoneCertController.text.length != 4 ||
                                                          phoneCode != _phoneCertController.text) {
                                                        activeToast('잘못된 인증번호입니다.');
                                                      } else {
                                                        phoneVerified = true;
                                                        certificationPopup = false;
                                                        _countDownController.reset();
                                                        setState(() {});
                                                      }
                                                    },
                                                    childWidget: Container(
                                                      width: 100,
                                                      height: 44,
                                                      decoration: BoxDecoration(
                                                        color: IdColors.textDefault,
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      child: Center(
                                                        child: uiCommon.styledText(
                                                            '번호확인', 15, 0, 1.6, FontWeight.w600, IdColors.white, TextAlign.left),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        ///////////////// 폰인증입력 end
                                        const IdSpace(spaceWidth: 0, spaceHeight: 4),
                                        Row(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 114),
                                            child: SizedBox(
                                              width: 291,
                                              child: uiCommon.styledText(
                                                  '휴대전화번호 변경을 위해서는 본인 인증이 필요합니다. 변경하실 휴대전화번호 입력 후 본인인증 버튼을 눌러 본인인증을 진행해주세요.',
                                                  14,
                                                  0,
                                                  1.6,
                                                  FontWeight.w400,
                                                  IdColors.textTertiary,
                                                  TextAlign.left),
                                            ),
                                          ),
                                          const IdSpace(spaceWidth: 45, spaceHeight: 0),
                                          Visibility(
                                              visible: certificationPopup,
                                              child: CircularCountDownTimer(
                                                duration: 60,
                                                initialDuration: 0,
                                                controller: _countDownController,
                                                width: 34,
                                                height: 34,
                                                ringColor: Colors.grey[300]!,
                                                ringGradient: null,
                                                fillColor: Colors.black,
                                                fillGradient: null,
                                                backgroundColor: IdColors.textTertiary,
                                                backgroundGradient: null,
                                                strokeWidth: 5.0,
                                                strokeCap: StrokeCap.round,
                                                textStyle: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
                                                textFormat: CountdownTextFormat.S,
                                                isReverse: false,
                                                isReverseAnimation: false,
                                                isTimerTextShown: true,
                                                autoStart: true,
                                                onStart: () {
                                                  debugPrint('Countdown Started');
                                                },
                                                onComplete: () {
                                                  //toastHandle('인증시간이 만료되었습니다.');
                                                  certificationPopup = false;
                                                  _countDownController.reset();
                                                  setState(() {});
                                                  debugPrint('Countdown Ended');
                                                },
                                                onChange: (String timeStamp) {
                                                  if (phoneVerified) {
                                                    certificationPopup = false;
                                                    _countDownController.reset();
                                                  }
                                                  debugPrint('Countdown Changed $timeStamp');
                                                },
                                                timeFormatterFunction: (defaultFormatterFunction, duration) {
                                                  if (duration.inSeconds == 0) {
                                                    return "0";
                                                  } else {
                                                    return Function.apply(defaultFormatterFunction, [duration]);
                                                  }
                                                },
                                              ))
                                        ]),
                                        const IdSpace(spaceWidth: 0, spaceHeight: 20),
                                        IdInfoFormat(
                                          formatTitle: '소속',
                                          formatContent: IdInputValidation(
                                            width: 406,
                                            height: 44,
                                            inputColor: IdColors.backgroundDefault,
                                            round: 8,
                                            controller: _companyController,
                                            textAlign: 'start',
                                            hintText: office,
                                            hintTextFontSize: 16,
                                            hintTextfontWeight: FontWeight.w400,
                                            hintTextFontColor: IdColors.textTertiary,
                                            keyboardType: 'text',
                                            validationText: '',
                                            validationVisible: false,
                                            vlaidationCheck: false,
                                            enabledBool: true,
                                          ),
                                        ),
                                        const IdSpace(spaceWidth: 0, spaceHeight: 20),
                                        IdInfoFormat(
                                          formatTitle: '사무실 주소',
                                          formatContent: Row(
                                            children: [
                                              IdInputValidation(
                                                width: 298,
                                                height: 44,
                                                inputColor: IdColors.backgroundDefault,
                                                round: 8,
                                                controller: _companyAddressController,
                                                textAlign: 'start',
                                                hintText: officeAddr,
                                                hintTextFontSize: 16,
                                                hintTextfontWeight: FontWeight.w400,
                                                hintTextFontColor: IdColors.textTertiary,
                                                keyboardType: 'text',
                                                validationText: '',
                                                validationVisible: false,
                                                vlaidationCheck: false,
                                                enabledBool: false,
                                              ),
                                              const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                              IdNormalBtn(
                                                onBtnPressed: () {
                                                  addressPopupVisible = true;
                                                  setState(() {});
                                                },
                                                childWidget: Container(
                                                  width: 100,
                                                  height: 44,
                                                  decoration: BoxDecoration(
                                                    color: IdColors.textDefault,
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Center(
                                                    child: uiCommon.styledText(
                                                        '주소찾기', 15, 0, 1.6, FontWeight.w600, IdColors.white, TextAlign.left),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: false,
                                          child: Column(
                                            children: [
                                              const IdSpace(spaceWidth: 0, spaceHeight: 20),
                                              IdInfoFormat(
                                                formatTitle: '',
                                                formatContent: IdInputValidation(
                                                  width: 406,
                                                  height: 44,
                                                  inputColor: IdColors.backgroundDefault,
                                                  round: 8,
                                                  controller: _companyDetailAddressController,
                                                  textAlign: 'start',
                                                  hintText: officeAddrDetail,
                                                  hintTextFontSize: 16,
                                                  hintTextfontWeight: FontWeight.w400,
                                                  hintTextFontColor: IdColors.textTertiary,
                                                  keyboardType: 'text',
                                                  validationText: '',
                                                  validationVisible: false,
                                                  vlaidationCheck: emailInputCheck,
                                                  enabledBool: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const IdSpace(spaceWidth: 0, spaceHeight: 20),
                                        IdInfoFormat(
                                          formatTitle: '아이디',
                                          formatContent: IdInputValidation(
                                            width: 406,
                                            height: 44,
                                            inputColor: IdColors.backgroundDefault,
                                            round: 8,
                                            controller: _userIdController,
                                            textAlign: 'start',
                                            hintText: userId,
                                            hintTextFontSize: 16,
                                            hintTextfontWeight: FontWeight.w400,
                                            hintTextFontColor: IdColors.textTertiary,
                                            keyboardType: 'text',
                                            validationText: '',
                                            validationVisible: false,
                                            vlaidationCheck: emailInputCheck,
                                            enabledBool: false,
                                          ),
                                        ),
                                        const IdSpace(spaceWidth: 0, spaceHeight: 20),
                                        IdInfoFormat(
                                          formatTitle: '현재 비밀번호',
                                          formatContent: Row(
                                            children: [
                                              IdInputValidation(
                                                width: 298,
                                                height: 44,
                                                inputColor: IdColors.backgroundDefault,
                                                round: 8,
                                                controller: _userPwController1,
                                                textAlign: 'start',
                                                hintText: obscureText(userPw),
                                                hintTextFontSize: 16,
                                                hintTextfontWeight: FontWeight.w400,
                                                hintTextFontColor: IdColors.black,
                                                keyboardType: 'password',
                                                validationText: '',
                                                validationVisible: false,
                                                vlaidationCheck: emailInputCheck,
                                                enabledBool: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const IdSpace(spaceWidth: 0, spaceHeight: 20),
                                        IdInfoFormat(
                                          formatTitle: '변경할 비밀번호',
                                          formatContent: Row(
                                            children: [
                                              IdInputValidation(
                                                width: 298,
                                                height: 44,
                                                inputColor: IdColors.backgroundDefault,
                                                round: 8,
                                                controller: _userPwController2,
                                                textAlign: 'start',
                                                hintText: obscureText(userPw),
                                                hintTextFontSize: 16,
                                                hintTextfontWeight: FontWeight.w400,
                                                hintTextFontColor: IdColors.black,
                                                keyboardType: 'password',
                                                validationText: '',
                                                validationVisible: false,
                                                vlaidationCheck: emailInputCheck,
                                                enabledBool: true,
                                              ),
                                              const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                              IdNormalBtn(
                                                onBtnPressed: () async {
                                                  RegExp exp = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!_-]).*$');
                                                  if (_userPwController1.text.length < 8 || _userPwController2.text.length < 8) {
                                                    activeToast('비밀번호가 8자리 이상 이어야 합니다.');
                                                    return;
                                                  } else if (!exp.hasMatch(_userPwController2.text)) {
                                                    activeToast('문자 &숫자 & 특수문자( _ , - , !) 가 동시에 포함되어야 합니다..');
                                                    return;
                                                  } else if (_userPwController1.text == _userPwController2.text) {
                                                    activeToast('현재 비밀번호와 동일합니다.');
                                                    return;
                                                  }

                                                  final ret1 = await IdApi.changePassoword_SSO(
                                                      GV.myInfoItem.userNo!, _userPwController1.text, _userPwController2.text);
                                                  if (ret1) {
                                                    activeToast('비밀번호변경이 성공했습니다.');
                                                  } else {
                                                    activeToast('비밀번호변경이 실패했습니다.');
                                                  }
                                                },
                                                childWidget: Container(
                                                  width: 100,
                                                  height: 44,
                                                  decoration: BoxDecoration(
                                                    color: IdColors.textDefault,
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Center(
                                                    child: uiCommon.styledText(
                                                        '변경', 15, 0, 1.6, FontWeight.w600, IdColors.white, TextAlign.left),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const IdSpace(spaceWidth: 184, spaceHeight: 0),
                                    //우측 명함 부분
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: 520,
                                          height: 50,
                                          child:
                                              uiCommon.styledText('명함', 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                                        ),
                                        const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                        Container(
                                          width: 520,
                                          height: 259.45,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: (ncardChekInt == 0)
                                              ? const IdImageBox(
                                                  imagePath: 'assets/img/img_dummy_namecard.png',
                                                  imageWidth: 520,
                                                  imageHeight: 259.45,
                                                  imageFit: BoxFit.cover)
                                              : (uploadImg1 != null)
                                                  ? uploadRawImg
                                                  : IdImageBox2(
                                                      imagePath: '$s3FileUrl',
                                                      imageWidth: 520,
                                                      imageHeight: 259.45,
                                                      round: 8,
                                                      imageFit: BoxFit.cover,
                                                    ),
                                        ),
                                        const IdSpace(spaceWidth: 0, spaceHeight: 10),
                                        Container(
                                          width: 520,
                                          height: 98,
                                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: IdColors.green5,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: uiCommon.styledText(
                                              '명함을 등록하시면 관리자 검토 후 딜 등록 메뉴 사용이 가능한 정회원으로 승급됩니다.\n승인 결과는 명함 등록 후 영엽일 기준 48시간 내에 회원 가입 시 등록하신 휴대전화번호로 전송됩니다.',
                                              14,
                                              0,
                                              1.6,
                                              FontWeight.w400,
                                              IdColors.textSecondly,
                                              TextAlign.left),
                                        ),
                                        const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                        Stack(
                                          children: [
                                            const SizedBox(
                                              width: 520,
                                              height: 38,
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: IdNormalBtn(
                                                onBtnPressed: () async {
                                                  await uploadFile();
                                                  setState(() {});
                                                },
                                                childWidget: Container(
                                                  width: 97,
                                                  height: 38,
                                                  decoration: BoxDecoration(
                                                    color: IdColors.textDefault,
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Center(
                                                    child: uiCommon.styledText(
                                                        '파일찾기', 14, 0, 1.6, FontWeight.w600, IdColors.white, TextAlign.left),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const IdSpace(spaceWidth: 0, spaceHeight: 100),
                                //하단 버튼
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    bottomBtn(
                                      '취소',
                                      IdColors.borderDefault,
                                      96,
                                      IdColors.textTertiary,
                                      () {
                                        uiCommon.IdMovePage(context, GV.pStrg.getHistoryPages()[GV.pStrg.getHistoryPages().length - 2]);
                                      },
                                    ),
                                    const IdSpace(spaceWidth: 12, spaceHeight: 0),
                                    bottomBtn(
                                      '확인',
                                      IdColors.green2,
                                      432,
                                      IdColors.white,
                                      () async {
                                        if (await setMember()) {
                                          fetchData();
                                        } else {}
                                      },
                                    ),
                                  ],
                                ),
                                const IdSpace(spaceWidth: 0, spaceHeight: 200),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //풋터
                      idCommonFooter(),
                    ],
                  ),
                ),
                //헤더
                idCommonHeader(),
                Visibility(
                  visible: addressPopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: IdColors.black8Per,
                      child: Center(
                        child: AddressPopup(
                          closeFuntion: () {
                            addressPopupVisible = false;
                            setState(() {});
                          },
                          addressWidget: KakaoAddressWidget(
                            onComplete: (kakaoAddress) {
                              // lotInfoList[lotListNum][0] = kakaoAddress.jibunAddress.split(' ')[2] + kakaoAddress.jibunAddress.split(' ')[3];
                              _companyAddressController.text = kakaoAddress.jibunAddress;
                              _companyDetailAddressController.text = kakaoAddress.buildingName;
                              setState(() {});
                            },
                            onClose: () {
                              addressPopupVisible = false;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                idHeadToastWidget()
              ],
            ),
          ),
        ));
  }
}
