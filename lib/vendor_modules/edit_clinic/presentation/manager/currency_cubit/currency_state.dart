import 'package:doctor_ack/vendor_modules/edit_clinic/domain/entities/currency_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CurrencyState extends Equatable {
  const CurrencyState();
}

class CurrencyInitial extends CurrencyState {
  @override
  List<Object> get props => [];
}

class GetCurrencyLoadingState extends CurrencyState {
  @override
  List<Object> get props => [];
}

class GetCurrencySuccessState extends CurrencyState {
  final CurrencyEntity currencyEntity;

  const GetCurrencySuccessState({required this.currencyEntity});
  @override
  List<Object> get props => [currencyEntity];
}

class GetCurrencyErrorState extends CurrencyState {
  final String message;

  const GetCurrencyErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
