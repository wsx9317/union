class DealLabelItem {
  String? label;
  String? labelColor;

  DealLabelItem({
    this.label,
    this.labelColor,
  });

  DealLabelItem.fromJson(Map<String, dynamic> json)
      : label = json['label'] as String?,
        labelColor = json['labelColor'] as String?;

  Map<String, dynamic> toJson() => {
        'label': label,
        'labelColor': labelColor,
      };

  @override
  String toString() {
    return 'DealLabelItem("label": "$label", "labelColor": "$labelColor")';
  }
}
