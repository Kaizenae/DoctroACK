import 'package:doctor_ack/modules/register/domain/entities/register_entity.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccessState extends RegisterState {
  final RegisterEntity registerEntity;
  const RegisterSuccessState({required this.registerEntity});

  @override
  List<Object?> get props => [];
}

class RegisterErrorState extends RegisterState {
  final String message;

  const RegisterErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class RegisterChangePasswordVisibilityState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterChangePasswordVisibilityState1 extends RegisterState {
  @override
  List<Object> get props => [];
}
