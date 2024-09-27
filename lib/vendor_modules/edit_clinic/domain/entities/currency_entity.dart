import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  final ResultEntity resultEntity;

  const CurrencyEntity({required this.resultEntity});

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
  final String symbol;

  const ResponseEntity({
    required this.id,
    required this.name,
    required this.symbol,
  });

  @override
  List<Object> get props => [
        id,
        name,
        symbol,
      ];
}
