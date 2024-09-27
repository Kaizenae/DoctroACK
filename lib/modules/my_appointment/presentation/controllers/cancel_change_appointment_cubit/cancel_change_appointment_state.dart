import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CancelChangeAppointmentsState extends Equatable {
  const CancelChangeAppointmentsState();
}

class CancelChangeAppointmentsInitial extends CancelChangeAppointmentsState {
  @override
  List<Object> get props => [];
}

class ChangeAppointmentLoadingState extends CancelChangeAppointmentsState {
  @override
  List<Object> get props => [];
}

class ChangeAppointmentSuccessState extends CancelChangeAppointmentsState {
  final CreateEntity createEntity;

  const ChangeAppointmentSuccessState({required this.createEntity});

  @override
  List<Object> get props => [createEntity];
}

class ChangeAppointmentErrorState extends CancelChangeAppointmentsState {
  final String message;

  const ChangeAppointmentErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class CancelAppointmentLoadingState extends CancelChangeAppointmentsState {
  @override
  List<Object> get props => [];
}

class CancelAppointmentSuccessState extends CancelChangeAppointmentsState {
  final CreateEntity createEntity;

  const CancelAppointmentSuccessState({required this.createEntity});

  @override
  List<Object> get props => [createEntity];
}

class CancelAppointmentErrorState extends CancelChangeAppointmentsState {
  final String message;

  const CancelAppointmentErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
