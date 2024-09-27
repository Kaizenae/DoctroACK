import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final ResultEntity resultEntity;

  const WalletEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;
  final double balance;

  const ResultEntity(
      {required this.status, required this.balance, required this.message});

  @override
  List<Object> get props => [status, balance, message];
}
