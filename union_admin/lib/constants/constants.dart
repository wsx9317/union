const String PACKAGENAME = 'unionCDPP_admin';
// String ID_BASE_URI = 'https://cdpp-cms.devsp.kr/';
String ID_BASE_URI = 'http:/localhost:8080';
String ID_SSO_URI = 'http:/localhost:8081';
String ID_WEB_URI = 'ws://localhost:8082/internal/socket-check';

//내 정보
const ID_DealDomi = '/api/domi/list';
const ID_Deal = '/api/management/list';
const ID_DealDetail = '/api/deal/detail';
const ID_Memo = '/api/management/memo/list';
const ID_MemoRegist = '/api/management/memo/insert';
const ID_LableList = '/api/management/label/check/list';
const ID_LableEdit = '/api/management/label/update';
const ID_StatusHistory = '/api/management/status/list';
const ID_AdditionCd = '/api/deal/location/list';
const ID_ProgressCd = '/api/deal/progress/list';
const ID_ProgressUpdate = '/api/management/status/insert';
const ID_DealDomiUpdate = '/api/domi/status/update';
const ID_DomiExcel = '/api/domi/list/excel';
const ID_DealExcel = '/api/management/list/excel';
const ID_Cert = '/api/deal/domi/cert';

/////////////////////////////////////
/// real page
////////////////////////////////////
const String PAGE_HOME_PAGE = "HOME"; //메인 홈
const String PAGE_DEAL_DOMI_PAGE = "DEALDOMI"; //딜 독점
const String PAGE_DEAL_DETAIL_PAGE = "DEALDETAIL"; //딜 독점
const String PAGE_DEAL_PAGE = "DEAL"; //딜 독점
const String PAGE_INTRO = "INTRO"; //로긴전 HTML
const String PAGE_TEST_PAGE = "TEST"; //TM TEST
const String PAGE_CERT_PDF_PAGE = "CERTPDF"; //인증서 PDF

/////////////////////////////////////
/// gloval variable
////////////////////////////////////
const String key_gv_login = "GV_LOGIN";
const String key_gv_mainpage = "GV_MAINPAGE";
const String key_gv_uuid = "GV_UUID";

const String key_page_with = 'GV_width';
////////////////////////////////////
/// bottombar
////////////////////////////////////
const String keyLoginYN = 'Unapproval'; //로그인 여부

/////////////////////////////////////
/// 공통 파라미터, 각 API에서 쓰는 파라미터들
////////////////////////////////////
const String Param_beforePage = '페이지 이름';
const String Param_dealNoString = 'dealnumber';
const String Param_dealDomiNoString = 'dealDominumber';
const String Param_dealDomiYN = 'N';
const String Param_typeString = 'type';

