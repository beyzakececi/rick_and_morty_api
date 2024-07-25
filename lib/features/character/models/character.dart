import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String name;

  Character({required this.name});

  @override
  List<Object> get props => [name];

  // JSON serialization
  Map<String, dynamic> toJson() => {'name': name};

  static Character fromJson(Map<String, dynamic> json) {
    return Character(name: json['name']);
  }
}
