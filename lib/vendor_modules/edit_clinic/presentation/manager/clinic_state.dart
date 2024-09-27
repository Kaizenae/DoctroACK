import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EditClinicState extends Equatable {
  const EditClinicState();
}

class EditClinicInitial extends EditClinicState {
  @override
  List<Object> get props => [];
}

class EditClinicProfileLoadingState extends EditClinicState {
  @override
  List<Object> get props => [];
}

class EditClinicProfileSuccessState extends EditClinicState {
  final CreateEntity createEntity;

  const EditClinicProfileSuccessState({required this.createEntity});
  @override
  List<Object> get props => [createEntity];
}

class EditClinicProfileErrorState extends EditClinicState {
  final String message;

  const EditClinicProfileErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class ChangeImageState extends EditClinicState {
  @override
  List<Object> get props => [];
}

class ChangeImageCoverState extends EditClinicState {
  @override
  List<Object> get props => [];
}
