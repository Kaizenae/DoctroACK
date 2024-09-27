import 'package:equatable/equatable.dart';

import '../../../domain/entities/advanced_sales_entity.dart';

abstract class AdvancedSalesState extends Equatable {
  const AdvancedSalesState();
}

class AdvancedSalesInitial extends AdvancedSalesState {
  @override
  List<Object> get props => [];
}

class GetAdvancedSalesLoadingState extends AdvancedSalesState {
  @override
  List<Object> get props => [];
}

class GetAdvancedSalesSuccessState extends AdvancedSalesState {
  final AdvancedSalesEntity advancedSalesEntity;

  const GetAdvancedSalesSuccessState({required this.advancedSalesEntity});
  @override
  List<Object> get props => [advancedSalesEntity];
}

class GetAdvancedSalesErrorState extends AdvancedSalesState {
  final String message;

  const GetAdvancedSalesErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
