import 'package:equatable/equatable.dart';

class CustomersEntity extends Equatable {
  final ResultEntity resultEntity;

  const CustomersEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;
  final List<ResponseEntity> response;

  const ResultEntity(
      {required this.status, required this.response, required this.message});

  @override
  List<Object> get props => [status, response, message];
}

class ResponseEntity extends Equatable {
  final int id;
  final String name;
  final String mobilePhone;
  final String email;

  const ResponseEntity({
    required this.id,
    required this.name,
    required this.mobilePhone,
    required this.email,
  });

  @override
  List<Object> get props => [id, name, mobilePhone, email];
}
