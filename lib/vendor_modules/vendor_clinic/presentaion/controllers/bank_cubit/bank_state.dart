part of 'bank_cubit.dart';

abstract class BankState extends Equatable {
  const BankState();
}

class BankInitial extends BankState {
  @override
  List<Object> get props => [];
}

class BankLoadingState extends BankState {
  @override
  List<Object> get props => [];
}

class BankSuccessState extends BankState {
  final BankEntity bankEntity;

  const BankSuccessState({required this.bankEntity});
  @override
  List<Object> get props => [bankEntity];
}

class BankErrorState extends BankState {
  final String message;

  const BankErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
