import 'package:doctor_ack/modules/forget_password/domain/entities/general_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();
}

class ForgetPasswordInitial extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

class SendOTPLoadingState extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

class SendOTPSuccessState extends ForgetPasswordState {
  final GeneralEntity generalEntity;
  const SendOTPSuccessState({required this.generalEntity});

  @override
  List<Object?> get props => [];
}

class SendOTPErrorState extends ForgetPasswordState {
  final String message;

  const SendOTPErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class VerifyOTPLoadingState extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

class VerifyOTPSuccessState extends ForgetPasswordState {
  final GeneralEntity generalEntity;
  const VerifyOTPSuccessState({required this.generalEntity});

  @override
  List<Object?> get props => [];
}

class VerifyOTPErrorState extends ForgetPasswordState {
  final String message;

  const VerifyOTPErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class NewPasswordLoadingState extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

class NewPasswordSuccessState extends ForgetPasswordState {
  final GeneralEntity generalEntity;
  const NewPasswordSuccessState({required this.generalEntity});

  @override
  List<Object?> get props => [];
}

class NewPasswordErrorState extends ForgetPasswordState {
  final String message;

  const NewPasswordErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ForgetPasswordChangePasswordVisibilityState extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

class ForgetPasswordChangePasswordVisibilityState1 extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}
