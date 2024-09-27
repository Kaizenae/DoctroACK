import 'package:equatable/equatable.dart';

class AdvancedSalesEntity extends Equatable {
  final ResultEntity resultEntity;

  const AdvancedSalesEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;
  final List<AdvancedSaleEntity> response;

  const ResultEntity(
      {required this.status, required this.response, required this.message});

  @override
  List<Object> get props => [status, response, message];
}

class AdvancedSaleEntity extends Equatable {
  final String date;
  final double amount;

  const AdvancedSaleEntity({
    required this.date,
    required this.amount,
  });

  @override
  List<Object> get props => [date, amount];
}
