import 'package:equatable/equatable.dart';

import '../../../domain/entities/states_entity.dart';

abstract class StatesState extends Equatable {
  const StatesState();
}

class StatesInitial extends StatesState {
  @override
  List<Object> get props => [];
}

class GetStatesLoadingState extends StatesState {
  @override
  List<Object> get props => [];
}

class GetStatesSuccessState extends StatesState {
  final StatesEntity statesEntity;

  const GetStatesSuccessState({required this.statesEntity});
  @override
  List<Object> get props => [statesEntity];
}

class GetStatesErrorState extends StatesState {
  final String message;

  const GetStatesErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
