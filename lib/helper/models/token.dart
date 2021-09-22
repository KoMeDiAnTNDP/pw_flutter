import 'package:equatable/equatable.dart';

class Token extends Equatable {
  Token({ required this.token});

  final String token;

  @override
  List<Object> get props => [token];

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['id_token']
    );
  }
}
