import 'package:equatable/equatable.dart';

class BankEntity extends Equatable {
  final ResultEntity resultEntity;

  const BankEntity({required this.resultEntity});

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
  List<Object> get props => [status, response];
}

class ResponseEntity extends Equatable {
  final String bankName;
  final String holderName;
  final String iban;
  final String holderNumber;
  final String currency;

  const ResponseEntity(
      {required this.bankName,
      required this.holderName,
      required this.iban,
      required this.holderNumber,
      required this.currency});

  @override
  List<Object> get props =>
      [bankName, holderName, holderNumber, currency, iban];
}
