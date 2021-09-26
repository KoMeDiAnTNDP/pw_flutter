import 'package:equatable/equatable.dart';

class FilteredUser extends Equatable {
  const FilteredUser({
    required this.id,
    required this.name
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];

  factory FilteredUser.fromJson(Map<String, dynamic> json) {
    return FilteredUser(id: json['id'], name: json['name']);
  }
}
