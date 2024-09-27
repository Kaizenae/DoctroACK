import 'package:equatable/equatable.dart';

class FinancesEntity extends Equatable {
  final ResultEntity resultEntity;

  const FinancesEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;
  final ResponseEntity response;

  const ResultEntity(
      {required this.status, required this.response, required this.message});

  @override
  List<Object> get props => [status, response, message];
}

class ResponseEntity extends Equatable {
  final String nextPayoutDate;
  final List<FinanceEntity> financeEntity;

  const ResponseEntity({
    required this.nextPayoutDate,
    required this.financeEntity,
  });

  @override
  List<Object> get props => [nextPayoutDate, financeEntity];
}

class FinanceEntity extends Equatable {
  final int paymentId;
  final String paymentName;
  final double amount;
  final String currency;
  final String date;
  final String pdf;

  const FinanceEntity({
    required this.paymentId,
    required this.paymentName,
    required this.amount,
    required this.currency,
    required this.date,
    required this.pdf,
  });

  @override
  List<Object> get props =>
      [paymentId, date, paymentName, amount, currency, pdf];
}
