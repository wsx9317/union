import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

// ignore_for_file: camel_case_types

class ssoMember {
  String? uIdx;
  String? uId;
  String? uPassword;
  String? returnUrl;
  String? uName;
  String? uEmail;
  String? uPhone;
  String? uCompanyName;
  String? uFilePath;
  String? uFileName;
  String? uPhoneOs;
  String? uPathCd;
  String? uPathVal;
  String? uSocialId;
  String? uRefreshToken;
  String? uLastLogin;
  String? uGrade;
  String? uOrganization;
  String? uCreateTime;
  String? uDepartment;
  String? uOfficeAddr;
  String? uOfficeAddrDetail;
  String? uJoinPath;
  String? uJoinPathEtc;
  String? uUserType;
  String? uNewPassword;
  String? s3FileUrl;
  String? accessToken;
  String? refreshToken;
  String? currentPassword;
  String? newPassword;
  String? callBackUrl;
  ssoMember({
    required this.uIdx,
     this.uId,
     this.uPassword,
     this.returnUrl,
     this.uName,
     this.uEmail,
     this.uPhone,
     this.uCompanyName,
     this.uFilePath,
     this.uFileName,
     this.uPhoneOs,
     this.uPathCd,
     this.uPathVal,
     this.uSocialId,
     this.uRefreshToken,
     this.uLastLogin,
     this.uGrade,
     this.uOrganization,
     this.uCreateTime,
     this.uDepartment,
     this.uOfficeAddr,
     this.uOfficeAddrDetail,
     this.uJoinPath,
     this.uJoinPathEtc,
     this.uUserType,
     this.uNewPassword,
     this.s3FileUrl,
     this.accessToken,
     this.refreshToken,
     this.currentPassword,
     this.newPassword,
     this.callBackUrl
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uIdx': uIdx,
      'uId': uId,
      'uPassword': uPassword,
      'returnUrl': returnUrl,
      'uName': uName,
      'uEmail': uEmail,
      'uPhone': uPhone,
      'uCompanyName': uCompanyName,
      'uFilePath': uFilePath,
      'uFileName': uFileName,
      'uPhoneOs': uPhoneOs,
      'uPathCd': uPathCd,
      'uPathVal': uPathVal,
      'uSocialId': uSocialId,
      'uRefreshToken': uRefreshToken,
      'uLastLogin': uLastLogin,
      'uGrade': uGrade,
      'uOrganization': uOrganization,
      'uCreateTime': uCreateTime,
      'uDepartment': uDepartment,
      'uOfficeAddr': uOfficeAddr,
      'uOfficeAddrDetail': uOfficeAddrDetail,
      'uJoinPath': uJoinPath,
      'uJoinPathEtc': uJoinPathEtc,
      'uUserType': uUserType,
      'uNewPassword': uNewPassword,
      's3FileUrl': s3FileUrl,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'callBackUrl': callBackUrl,
    };
  }

  factory ssoMember.fromJson(Map<String, dynamic> map) {
    return ssoMember(
      uIdx: map['uIdx'] as String?,
      uId: map['uId'] as String?,
      uPassword: map['uPassword'] as String?,
      returnUrl: map['returnUrl'] as String?,
      uName: map['uName'] as String?,
      uEmail: map['uEmail'] as String?,
      uPhone: map['uPhone'] as String?,
      uCompanyName: map['uCompanyName'] as String?,
      uFilePath: map['uFilePath'] as String?,
      uFileName: map['uFileName'] as String?,
      uPhoneOs: map['uPhoneOs'] as String?,
      uPathCd: map['uPathCd'] as String?,
      uPathVal: map['uPathVal'] as String?,
      uSocialId: map['uSocialId'] as String?,
      uRefreshToken: map['uRefreshToken'] as String?,
      uLastLogin: map['uLastLogin'] as String?,
      uGrade: map['uGrade'] as String?,
      uOrganization: map['uOrganization'] as String?,
      uCreateTime: map['uCreateTime'] as String?,
      uDepartment: map['uDepartment'] as String?,
      uOfficeAddr: map['uOfficeAddr'] as String?,
      uOfficeAddrDetail: map['uOfficeAddrDetail'] as String?,
      uJoinPath: map['uJoinPath'] as String?,
      uJoinPathEtc: map['uJoinPathEtc'] as String?,
      uUserType: map['uUserType'] as String?,
      uNewPassword: map['uNewPassword'] as String?,
      s3FileUrl: map['s3FileUrl'] as String?,
      accessToken: map['accessToken'] as String?,
      refreshToken: map['refreshToken'] as String?,
      currentPassword: map['currentPassword'] as String?,
      newPassword: map['newPassword'] as String?,
      callBackUrl: map['callBackUrl'] as String?,
    );
  }

  @override
  String toString() {
    return 'ssoMember(uIdx: $uIdx, uId: $uId, uPassword: $uPassword, returnUrl: $returnUrl, uName: $uName, uEmail: $uEmail, uPhone: $uPhone, uCompanyName: $uCompanyName, uFilePath: $uFilePath, uFileName: $uFileName, uPhoneOs: $uPhoneOs, uPathCd: $uPathCd, uPathVal: $uPathVal, uSocialId: $uSocialId, uRefreshToken: $uRefreshToken, uLastLogin: $uLastLogin, uGrade: $uGrade, uOrganization: $uOrganization, uCreateTime: $uCreateTime, uDepartment: $uDepartment, uOfficeAddr: $uOfficeAddr, uOfficeAddrDetail: $uOfficeAddrDetail, uJoinPath: $uJoinPath, uJoinPathEtc: $uJoinPathEtc, uUserType: $uUserType, uNewPassword: $uNewPassword, s3FileUrl: $s3FileUrl, accessToken: $accessToken, refreshToken: $refreshToken, currentPassword: $currentPassword, newPassword: $newPassword, callBackUrl: $callBackUrl)';
  }
}

