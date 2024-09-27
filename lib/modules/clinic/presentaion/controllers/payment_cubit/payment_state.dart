part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentIntentLoadingState extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentIntentSuccessState extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentIntentErrorState extends PaymentState {
  @override
  List<Object> get props => [];
}
