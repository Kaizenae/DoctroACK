part of 'check_payment_cubit.dart';

abstract class CheckPaymentState extends Equatable {
  const CheckPaymentState();
}

class CheckPaymentInitial extends CheckPaymentState {
  @override
  List<Object> get props => [];
}

class CheckPaymentLoadingState extends CheckPaymentState {
  @override
  List<Object> get props => [];
}

class CheckPaymentSuccessState extends CheckPaymentState {
  final CheckPaymentEntity checkPaymentEntity;

  const CheckPaymentSuccessState({required this.checkPaymentEntity});
  @override
  List<Object> get props => [];
}

class CheckPaymentErrorState extends CheckPaymentState {
  final String message;

  const CheckPaymentErrorState({required this.message});
  @override
  List<Object> get props => [];
}
