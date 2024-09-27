import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final ResultEntity resultEntity;

  const LoginEntity({
    required this.resultEntity,
  });

  @override
  List<Object?> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;
  final BodyEntity body;

  const ResultEntity({
    required this.status,
    required this.message,
    required this.body,
  });

  @override
  List<Object?> get props => [status, message, body];
}

class BodyEntity extends Equatable {
  final String token;
  final String expireToken;
  final String type;
  final String role;
  final int id;
  final int partnerId;

  const BodyEntity({
    required this.token,
    required this.expireToken,
    required this.id,
    required this.partnerId,
    required this.type,
    required this.role,
  });

  @override
  List<Object> get props => [token, expireToken, type, role, id, partnerId];
}
