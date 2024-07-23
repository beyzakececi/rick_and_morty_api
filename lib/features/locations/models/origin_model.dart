import 'package:json_annotation/json_annotation.dart';

part 'origin_model.g.dart';


@JsonSerializable()
class Origin {
  final String name;
  final String url;

  Origin({
    required this.name,
    required this.url,
  });

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      name: json['name'],
      url: json['url'],
    );
  }
}
