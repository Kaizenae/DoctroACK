import 'package:equatable/equatable.dart';

import '../../../domain/entities/clinic_entity.dart';

abstract class ClinicState extends Equatable {
  const ClinicState();
}

class ClinicInitial extends ClinicState {
  @override
  List<Object> get props => [];
}

class SelectServiceLoadingState extends ClinicState {
  @override
  List<Object> get props => [];
}

class SelectServiceState extends ClinicState {
  @override
  List<Object> get props => [];
}

class GetClinicLoadingState extends ClinicState {
  @override
  List<Object> get props => [];
}

class GetClinicSuccessState extends ClinicState {
  final ClinicEntity clinicEntity;

  const GetClinicSuccessState({required this.clinicEntity});

  @override
  List<Object> get props => [clinicEntity];
}

class GetClinicErrorState extends ClinicState {
  final String message;

  const GetClinicErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
