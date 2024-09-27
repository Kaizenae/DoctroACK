import 'package:equatable/equatable.dart';

import '../../../domain/entities/clinic_services_entity.dart';

abstract class ClinicServicesState extends Equatable {
  const ClinicServicesState();
}

class ClinicInitial extends ClinicServicesState {
  @override
  List<Object> get props => [];
}

class GetClinicServicesLoadingState extends ClinicServicesState {
  @override
  List<Object> get props => [];
}

class GetClinicServicesSuccessState extends ClinicServicesState {
  final ClinicServicesEntity clinicEntity;

  const GetClinicServicesSuccessState({required this.clinicEntity});

  @override
  List<Object> get props => [clinicEntity];
}

class GetClinicServicesErrorState extends ClinicServicesState {
  final String message;

  const GetClinicServicesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SelectServiceLoadingState extends ClinicServicesState {
  @override
  List<Object> get props => [];
}

class SelectServiceState extends ClinicServicesState {
  @override
  List<Object> get props => [];
}
