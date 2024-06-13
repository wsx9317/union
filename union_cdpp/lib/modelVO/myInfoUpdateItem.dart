// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyInfoUpdateItem {
  String? uIdx;
  String? uId;
  String? uEmail;
  String? uPhone;
  String? uDepartment;
  String? uOfficeAddr;
  String? uOfficeAddrDetail;
  String? callBackUrl;

  MyInfoUpdateItem(
      {this.uIdx,
      this.uId,
      this.uEmail,
      this.uPhone,
      this.uDepartment,
      this.uOfficeAddr,
      this.uOfficeAddrDetail,
      this.callBackUrl});

  MyInfoUpdateItem.fromJson(Map<String, dynamic> json) {
    uIdx = json['uIdx'];
    uId = json['uId'];
    uEmail = json['uEmail'];
    uPhone = json['uPhone'];
    uDepartment = json['uDepartment'];
    uOfficeAddr = json['uOfficeAddr'];
    uOfficeAddrDetail = json['uOfficeAddrDetail'];
    callBackUrl = json['callBackUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uIdx'] = this.uIdx;
    data['uId'] = this.uId;
    data['uEmail'] = this.uEmail;
    data['uPhone'] = this.uPhone;
    data['uDepartment'] = this.uDepartment;
    data['uOfficeAddr'] = this.uOfficeAddr;
    data['uOfficeAddrDetail'] = this.uOfficeAddrDetail;
    data['callBackUrl'] = this.callBackUrl;
    return data;
  }

  @override
  String toString() {
    return 'MyInfoUpdateItem(uIdx: $uIdx, uId: $uId, uEmail: $uEmail, uPhone: $uPhone, uDepartment: $uDepartment, uOfficeAddr: $uOfficeAddr, uOfficeAddrDetail: $uOfficeAddrDetail, callBackUrl: $callBackUrl)';
  }
}
