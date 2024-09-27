import 'package:equatable/equatable.dart';

import '../../domain/entities/my_appointment_entity.dart';

abstract class MyAppointmentsState extends Equatable {
  const MyAppointmentsState();
}

class MyAppointmentsInitial extends MyAppointmentsState {
  @override
  List<Object> get props => [];
}

class GetMyAppointmentLoadingState extends MyAppointmentsState {
  @override
  List<Object> get props => [];
}

class GetMyAppointmentSuccessState extends MyAppointmentsState {
  final MyAppointmentEntity myAppointmentEntity;

  const GetMyAppointmentSuccessState({required this.myAppointmentEntity});

  @override
  List<Object> get props => [myAppointmentEntity];
}

class GetMyAppointmentErrorState extends MyAppointmentsState {
  final String message;

  const GetMyAppointmentErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
