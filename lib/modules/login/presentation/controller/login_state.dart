import 'package:doctor_ack/modules/login/domain/entities/login_entity.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  final LoginEntity loginEntity;
  const LoginSuccessState({required this.loginEntity});

  @override
  List<Object> get props => [loginEntity];
}

class LoginErrorState extends LoginState {
  final String message;

  const LoginErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoginChangePasswordVisibilityState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginChangePasswordVisibilityState1 extends LoginState {
  @override
  List<Object> get props => [];
}
