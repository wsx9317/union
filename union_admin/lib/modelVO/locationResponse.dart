import 'package:union_admin/modelVO/codeItem.dart';

class LocationResponse {
  final List<CodeItem>? location;

  LocationResponse({
    this.location,
  });

  LocationResponse.fromJson(Map<String, dynamic> json)
      : location = (json['location'] as List?)?.map((dynamic e) => CodeItem.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'location': location?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'LocationResponse(progress:$location)';
  }
}
