const String PACKAGENAME = 'unionCDPP____';
String ID_BASE_URI = 'http:/localhost:8082';
String ID_SSO_URI = 'http:/localhost:8081';
String ID_WEB_URI = 'ws://localhost:8082/internal/socket-check';

//내 정보
const ID_MyInfo = '/api/v1/deal/myinfo';
//내 정보 from sso
const ID_MyInfo_SSO = '/user/info';
//공통 코드(위치 특이사항)
const ID_Location_Detail = '/api/v1/deal/common-code/LOCATION_DETAIL';
//공통 코드(건물 특이사항)
const ID_Item_Detail = '/api/v1/deal/common-code/ITEM_DETAIL';
//내 딜 카운트(대쉬보드에서 쓸거)
const ID_MyDealCnt = '/api/v1/deal/myinfo';
//내 정보 업데이트
const ID_MyInfo_Update = '/api/v1/deal/update-myinfo';
//내 딜
const ID_MyDeal = '/api/v1/deal/mydeal';
//내 딜 상세
const ID_MyDeal_Detail = '/api/v1/deal/mydealDetail';
//내 딜 카운트
const ID_MyDeal_Count = '/api/v1/deal/deal-count';
//내 딜 상세 메모 리스트
const ID_MyDeal_MemoList = '/api/v1/deal/memo';
//내 딜 상세 메모 등록
const ID_MyDeal_Register_Memo = '/api/v1/deal/register-memo';
//내 알림
const ID_MyAlarm = '/api/v1/deal/mydealAlarm';
//내 알림 확인
const ID_MyAlarmCheck = '/api/v1/deal/check-mydealAlarm';
//딜 NO 생성
const ID_DealNo = '/api/v1/deal/generate-dealNo';
//딜 대지 정보 (외부 API)
const ID_Deal_landInfo = '/api/v1/deal/getNewConsEnrollDealDetails';
//딜 건물 정보 (외부 API)
const ID_Deal_buildingInfo = '/api/v1/deal/getBuildingEnrollDealDetails';
//딜 등록
const ID_Deal_register = '/api/v1/deal/register';
//딜 업데이트
const ID_Deal_update = '/api/v1/deal/update';
//공지사항 리스트
const ID_NoticeList = '/api/v1/deal/dealNotice';
//공지사항 상세
const ID_NoticeDetail = '/api/v1/deal/notice/info';
//공지사항 리스트
const ID_Apply_Domi = '/api/v1/deal/apply-domi';
//FAQ 리스트
const ID_FaqList = '/api/v1/deal/dealFAQ';
//인증서
const ID_Cert = '/api/v1/deal/domi/cert';
//임시 파일 업로드
const ID_FileUpload = '/api/v1/deal/upload-temp-file';
//LoginCheck용
const ID_LoginCheck = '/internal/login-check';
//LoginCheck용
const ID_ChangePwd_SSO = '/user/change-pw';
//내 정보 업데이트
const ID_MyInfo_Update_SSO = '/user/update';
//SMS 인증번호 발급
const ID_RequestSmsCode_SSO = '/auth/request-sms-code';
//임시 파일 업데이트
const ID_FileUpdate = '/api/v1/deal/update-file';

/////////////////////////////////////
/// real page
////////////////////////////////////
const String PAGE_HOME_PAGE = "HOME"; //메인 홈
const String PAGE_MYINFO_PAGE = "MYINFO"; //마이페이지 내 정보
const String PAGE_MYDEAL_PAGE = "MYDEAL"; //마이페이지 내가 등록한 딜
const String PAGE_MYDEAL_DETAIL_PAGE = "MYDEALDETAIL"; //마이페이지 내가 등록한 딜 상세
const String PAGE_MYALARM_PAGE = "MYALARM"; //마이페이지 알림
const String PAGE_NOTICE_PAGE = "NOTICE"; //공지사항
const String PAGE_NOTICE_DETAIL_PAGE = "NOTICEDETAIL"; //공지사항 상세
const String PAGE_FAQ_PAGE = "FAQ"; //FAQ
const String PAGE_DEAL_STEP_01_PAGE = "DEALSTEP01"; //딜 등록 스텝 01
const String PAGE_DEAL_STEP_02_1_PAGE = "DEALSTEP02_1"; //딜 등록 스텝 02_1
const String PAGE_DEAL_STEP_02_2_PAGE = "DEALSTEP02_2"; //딜 등록 스텝 02_2
const String PAGE_DEAL_STEP_03_1_PAGE = "DEALSTEP03_1"; //딜 등록 스텝 03_1
const String PAGE_DEAL_STEP_03_2_PAGE = "DEALSTEP03_2"; //딜 등록 스텝 03_2
const String PAGE_DEAL_STEP_04_1_PAGE = "DEALSTEP04_1"; //딜 등록 스텝 04_1(등록의 마지막)
const String PAGE_DEAL_STEP_04_2_PAGE = "DEALSTEP04_2"; //딜 등록 스텝 04_2(완료)
const String PAGE_DEAL_STEP_04_3_PAGE = "DEALSTEP04_3"; //딜 등록 스텝 04_3 (독점계약 서약서)
const String PAGE_DEAL_STEP_04_4_PAGE = "DEALSTEP04_4"; //딜 등록 스텝 04_4 (독점계약 완료)
const String PAGE_TM_PDF_PAGE = "TMPDF"; //TM PDF
const String PAGE_CERT_PDF_PAGE = "CERTPDF"; //인증서 PDF
const String PAGE_INTRO = "INTRO"; //로긴전 HTML
const String PAGE_INTRO2 = "INTRO2"; //로긴전 HTML
const String PAGE_INTRO3 = "INTRO3"; //로긴전 HTML
const String PAGE_LOGGED_INTRO = "INTRO."; //로긴후 HTML
const String PAGE_LOGGED_INTRO2 = "INTRO2."; //로긴후 HTML
const String PAGE_LOGGED_INTRO3 = "INTRO3."; //로긴후 HTML
const String PAGE_LOGIN = "LOGIN"; //login
const String PAGE_SIGNUP = "SIGNUP"; //login
const String PAGE_FIND_IDPWD = "FINDIDPWD"; //login

const String PAGE_TEST_PAGE = "TEST"; //TM TEST

/////////////////////////////////////
/// error page
////////////////////////////////////
const String PAGE_404_PAGE = "ERROR404"; //에러 404
const String PAGE_500_PAGE = "ERROR500"; //에러 404
const String PAGE_NULL_PAGE = "ERRORNULL"; //에러 404

/////////////////////////////////////
/// gloval variable
////////////////////////////////////
const String key_gv_login = "GV_LOGIN";
const String key_gv_mainpage = "GV_MAINPAGE";
const String key_gv_uuid = "GV_UUID";
const String key_gv_lastused = "GV_LASTUSED";

////////////////////////////////////
/// bottombar
////////////////////////////////////
const String keyLoginYN = 'Unapproval'; //로그인 여부

/////////////////////////////////////
/// 공통 파라미터, 각 API에서 쓰는 파라미터들
////////////////////////////////////
const String Param_commonUserId = '아이디';
const String Param_commonUserPwd = 'commonUserPwd';
const String Param_commonUserNo = '유저번호';
const String Param_commonUserName = '유저이름';
const String Param_commonUserOffice = '유저회사';
const String Param_myDealNo = '딜넘버';
const String Param_newDealNo = '새로운 딜넘버';
const String Param_noticeNo = '공지사항no';
const String Param_dealType = '딜종류';
const String Param_dealCategory = '딜유형';
const String Param_exclusiveContract = 'unkown';
const String Param_nowPage = '현재페이지';
const String Param_registrantType = '등록자';
const String Param_regOrderCntStr = '갯수';
const String Param_dominantlyOwnedStr = '독점유무';
const String Param_rentRollRegist = '렌트롤등록';
const String Param_pdfStatus = 'pdf';
const String Param_pageType = 'introPage';
const String Param_classType = 'classType';
const String Param_dealAddress = '딜주소';

const String Param_openMyalarmPop = 'N';
const String Param_myAlarmLogNo = '알람로그넘버';
const String Param_myAlarmStatus = '알람상태';
const String Param_myAlarmTitle = '알람타이틀';
const String Param_myalarmContent = '알람컨텐츠';
