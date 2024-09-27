import 'package:doctor_ack/modules/my_appointment/domain/entities/appointment_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();
}

class AppointmentInitial extends AppointmentState {
  @override
  List<Object> get props => [];
}

class GetAppointmentLoadingState extends AppointmentState {
  @override
  List<Object> get props => [];
}

class GetAppointmentSuccessState extends AppointmentState {
  final UserAppointmentEntity appointmentEntity;

  const GetAppointmentSuccessState({required this.appointmentEntity});

  @override
  List<Object> get props => [appointmentEntity];
}

class GetAppointmentErrorState extends AppointmentState {
  final String message;

  const GetAppointmentErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
