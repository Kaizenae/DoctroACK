part of 'clinic_profile_cubit.dart';

abstract class ClinicProfileState extends Equatable {
  const ClinicProfileState();
}

class ClinicProfileInitial extends ClinicProfileState {
  @override
  List<Object> get props => [];
}

class ClinicProfileLoadingState extends ClinicProfileState {
  @override
  List<Object> get props => [];
}

class ClinicProfileSuccessState extends ClinicProfileState {
  final ClinicProfileEntity clinicProfileEntity;

  const ClinicProfileSuccessState({required this.clinicProfileEntity});
  @override
  List<Object> get props => [clinicProfileEntity];
}

class ClinicProfileErrorState extends ClinicProfileState {
  final String message;

  const ClinicProfileErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class SelectServiceLoadingState extends ClinicProfileState {
  @override
  List<Object> get props => [];
}

class SelectServiceState extends ClinicProfileState {
  @override
  List<Object> get props => [];
}
