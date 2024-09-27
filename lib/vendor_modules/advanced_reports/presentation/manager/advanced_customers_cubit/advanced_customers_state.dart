import 'package:equatable/equatable.dart';

import '../../../domain/entities/advanced_customers_entity.dart';

abstract class AdvancedCustomersState extends Equatable {
  const AdvancedCustomersState();
}

class AdvancedCustomersInitial extends AdvancedCustomersState {
  @override
  List<Object> get props => [];
}

class GetAdvancedCustomersLoadingState extends AdvancedCustomersState {
  @override
  List<Object> get props => [];
}

class GetAdvancedCustomersSuccessState extends AdvancedCustomersState {
  final AdvancedCustomersEntity advancedCustomersEntity;

  const GetAdvancedCustomersSuccessState(
      {required this.advancedCustomersEntity});
  @override
  List<Object> get props => [advancedCustomersEntity];
}

class GetAdvancedCustomersErrorState extends AdvancedCustomersState {
  final String message;

  const GetAdvancedCustomersErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
