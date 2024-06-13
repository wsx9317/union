class LabelItem {
  String? dealNo;
  String? label;
  String? type;
  String? labelColor;
  String? delYn;
  String? createId;
  String? updateId;

  LabelItem({
    this.dealNo,
    this.label,
    this.type,
    this.labelColor,
    this.delYn,
    this.createId,
    this.updateId,
  });

  factory LabelItem.fromJson(Map<String, dynamic> json) {
    return LabelItem(
      dealNo: json['dealNo'] as String?,
      label: json['label'] as String?,
      type: json['type'] as String?,
      labelColor: json['labelColor'] as String?,
      delYn: json['delYn'] as String?,
      createId: json['createId'] as String?,
      updateId: json['updateId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'dealNo': dealNo,
        'label': label,
        'type': type,
        'labelColor': labelColor,
        'delYn': delYn,
        'createId': createId,
        'updateId': updateId,
      };

  @override
  String toString() {
    return 'LabelItem(dealNo: $dealNo, label: $label, type: $type, labelColor: $labelColor, delYn: $delYn, createId: $createId, updateId: $updateId)';
  }
}
