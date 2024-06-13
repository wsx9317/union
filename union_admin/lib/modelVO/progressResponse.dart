import 'package:union_admin/modelVO/codeItem.dart';

class ProgressResponse {
  final List<CodeItem>? progress;

  ProgressResponse({
    this.progress,
  });

  ProgressResponse.fromJson(Map<String, dynamic> json)
      : progress = (json['progress'] as List?)?.map((dynamic e) => CodeItem.fromJson(e as Map<String, dynamic>)).toList();
  Map<String, dynamic> toJson() => {
        'progress': progress?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'ProgressResponse(progress:$progress)';
  }
}
