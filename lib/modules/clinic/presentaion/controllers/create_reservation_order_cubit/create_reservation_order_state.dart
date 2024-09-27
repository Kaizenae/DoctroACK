import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CreateReservationOrderState extends Equatable {
  const CreateReservationOrderState();
}

class ClinicInitial extends CreateReservationOrderState {
  @override
  List<Object> get props => [];
}

class CreateReservationOrderLoadingState extends CreateReservationOrderState {
  @override
  List<Object> get props => [];
}

class CreateReservationOrderSuccessState extends CreateReservationOrderState {
  final CreateEntity createEntity;

  const CreateReservationOrderSuccessState({required this.createEntity});

  @override
  List<Object> get props => [createEntity];
}

class CreateReservationOrderErrorState extends CreateReservationOrderState {
  final String message;

  const CreateReservationOrderErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateAppointmentWalletLoadingState extends CreateReservationOrderState {
  @override
  List<Object> get props => [];
}

class CreateAppointmentWalletSuccessState extends CreateReservationOrderState {
  final CreateEntity createEntity;

  const CreateAppointmentWalletSuccessState({required this.createEntity});

  @override
  List<Object> get props => [createEntity];
}

class CreateAppointmentWalletErrorState extends CreateReservationOrderState {
  final String message;

  const CreateAppointmentWalletErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
