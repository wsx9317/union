class LabelEditItem {
  int? dealNo;
  String? label;
  String? dealLabelNo;
  String? labelColor;
  int? checked;

  LabelEditItem({
    this.dealNo,
    this.label,
    this.dealLabelNo,
    this.labelColor,
    this.checked,
  });

  factory LabelEditItem.fromJson(Map<String, dynamic> json) {
    return LabelEditItem(
      dealNo: json['dealNo'] as int?,
      label: json['label'] as String?,
      dealLabelNo: json['dealLabelNo'] as String?,
      labelColor: json['labelColor'] as String?,
      checked: json['checked'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'dealNo': dealNo,
        'label': label,
        'dealLabelNo': dealLabelNo,
        'labelColor': labelColor,
        'checked': checked,
      };

  @override
  String toString() {
    return 'LabelEditItem(dealNo: $dealNo, label: $label, dealLabelNo: $dealLabelNo, labelColor: $labelColor, checked: $checked)';
  }
}
