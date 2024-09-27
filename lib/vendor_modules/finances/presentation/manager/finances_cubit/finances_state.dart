import 'package:equatable/equatable.dart';

import '../../../domain/entities/finances_entity.dart';

abstract class FinancesState extends Equatable {
  const FinancesState();
}

class FinancesInitial extends FinancesState {
  @override
  List<Object> get props => [];
}

class GetFinancesLoadingState extends FinancesState {
  @override
  List<Object> get props => [];
}

class GetFinancesSuccessState extends FinancesState {
  final FinancesEntity financesEntity;

  const GetFinancesSuccessState({required this.financesEntity});
  @override
  List<Object> get props => [financesEntity];
}

class GetFinancesErrorState extends FinancesState {
  final String message;

  const GetFinancesErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
