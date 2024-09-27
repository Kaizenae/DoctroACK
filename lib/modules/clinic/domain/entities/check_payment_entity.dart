import 'package:equatable/equatable.dart';

class CheckPaymentEntity extends Equatable {
  final ResultEntity resultEntity;

  const CheckPaymentEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;
  final bool paymentStatus;

  const ResultEntity(
      {required this.status,
      required this.paymentStatus,
      required this.message});

  @override
  List<Object> get props => [status, paymentStatus];
}
