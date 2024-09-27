import 'package:doctor_ack/modules/forget_password/domain/entities/general_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ChangePasswordStates extends Equatable {
  const ChangePasswordStates();
}

class InitChangePasswordState extends ChangePasswordStates {
  @override
  List<Object> get props => [];
}

class ChangePasswordLoadingState extends ChangePasswordStates {
  @override
  List<Object> get props => [];
}

class ChangePasswordSuccessState extends ChangePasswordStates {
  final GeneralEntity generalEntity;

  const ChangePasswordSuccessState({required this.generalEntity});

  @override
  List<Object?> get props => [generalEntity];
}

class ChangePasswordErrorState extends ChangePasswordStates {
  final String message;

  const ChangePasswordErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ChangePasswordVisibilityState extends ChangePasswordStates {
  @override
  List<Object> get props => [];
}

class ChangeEyeConfirmState extends ChangePasswordStates {
  @override
  List<Object> get props => [];
}
