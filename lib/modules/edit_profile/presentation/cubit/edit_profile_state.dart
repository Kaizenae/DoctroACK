import 'package:doctor_ack/modules/forget_password/domain/entities/general_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EditProfileStates extends Equatable {}

class InitEditProfileState extends EditProfileStates {
  @override
  List<Object?> get props => [];
}

class ChangeImageState extends EditProfileStates {
  @override
  List<Object> get props => [];
}

class EditProfileLoadingState extends EditProfileStates {
  @override
  List<Object> get props => [];
}

class EditProfileSuccessState extends EditProfileStates {
  final GeneralEntity generalEntity;

  EditProfileSuccessState({required this.generalEntity});

  @override
  List<Object> get props => [generalEntity];
}

class EditProfileErrorState extends EditProfileStates {
  final String message;

  EditProfileErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class DeleteUserAccountLoading extends EditProfileStates {
  @override
  List<Object> get props => [];
}

class DeleteUserAccountSuccess extends EditProfileStates {
  final GeneralEntity createEntity;

  DeleteUserAccountSuccess({required this.createEntity});
  @override
  List<Object> get props => [createEntity];
}

class DeleteUserAccountError extends EditProfileStates {
  final String message;

  DeleteUserAccountError({required this.message});
  @override
  List<Object> get props => [message];
}
