import 'dart:convert';

class DealRegisterItem {
  int? regOrder;
  bool? dominantlyOwned;

  DealRegisterItem({
    this.regOrder,
    this.dominantlyOwned,
  });

  DealRegisterItem.fromJson(Map<String, dynamic> json)
      : regOrder = json['regOrder'] as int?,
        dominantlyOwned = json['dominantlyOwned'] as bool?;

  Map<String, dynamic> toJson() => {
        'regOrder': regOrder,
        'dominantlyOwned': dominantlyOwned,
      };

  @override
  String toString() {
    return 'DealRegisterItem(regOrder: $regOrder, dominantlyOwned: $dominantlyOwned)';
  }
}
