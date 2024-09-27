import 'package:equatable/equatable.dart';

import '../../../domain/entities/available_times_entity.dart';

abstract class AvailableTimesState extends Equatable {
  const AvailableTimesState();
}

class ClinicInitial extends AvailableTimesState {
  @override
  List<Object> get props => [];
}

class GetAvailableTimesLoadingState extends AvailableTimesState {
  @override
  List<Object> get props => [];
}

class GetAvailableTimesSuccessState extends AvailableTimesState {
  final AvailableTimesEntity availableTimesEntity;

  const GetAvailableTimesSuccessState({required this.availableTimesEntity});

  @override
  List<Object> get props => [availableTimesEntity];
}

class GetAvailableTimesErrorState extends AvailableTimesState {
  final String message;

  const GetAvailableTimesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SelectServiceLoadingState extends AvailableTimesState {
  @override
  List<Object> get props => [];
}

class SelectServiceState extends AvailableTimesState {
  @override
  List<Object> get props => [];
}
