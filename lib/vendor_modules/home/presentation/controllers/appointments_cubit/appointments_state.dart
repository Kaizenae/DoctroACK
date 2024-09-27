import 'package:equatable/equatable.dart';

import '../../../domain/entities/appointments_entity.dart';

abstract class AppointmentsState extends Equatable {
  const AppointmentsState();
}

class AppointmentsInitial extends AppointmentsState {
  @override
  List<Object> get props => [];
}

class GetAppointmentsLoadingState extends AppointmentsState {
  @override
  List<Object> get props => [];
}

class GetAppointmentsSuccessState extends AppointmentsState {
  final AppointmentsEntity appointmentsEntity;

  const GetAppointmentsSuccessState({required this.appointmentsEntity});
  @override
  List<Object> get props => [appointmentsEntity];
}

class GetAppointmentsErrorState extends AppointmentsState {
  final String message;

  const GetAppointmentsErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
