class LabelItem {
  String? dealLabelNo;
  String? label;
  String? labelColor;

  LabelItem({
    this.dealLabelNo,
    this.label,
    this.labelColor,
  });

  LabelItem.fromJson(Map<String, dynamic> json)
      : dealLabelNo = json['dealLabelNo'] as String?,
        label = json['label'] as String?,
        labelColor = json['labelColor'] as String?;

  Map<String, dynamic> toJson() => {
        'dealLabelNo': dealLabelNo,
        'label': label,
        'labelColor': labelColor,
      };

  @override
  String toString() {
    return 'LabelItem(dealLabelNo: $dealLabelNo, label: $label, labelColor: $labelColor)';
  }
}
