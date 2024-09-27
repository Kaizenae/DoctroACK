part of 'change_user_role_cubit.dart';

abstract class ChangeUserRoleState extends Equatable {
  const ChangeUserRoleState();
}

class ChangeUserRoleInitial extends ChangeUserRoleState {
  @override
  List<Object> get props => [];
}

class ChangeUserLoadingState extends ChangeUserRoleState {
  @override
  List<Object> get props => [];
}

class ChangeUserSuccessState extends ChangeUserRoleState {
  final CreateEntity createEntity;

  const ChangeUserSuccessState({required this.createEntity});
  @override
  List<Object> get props => [createEntity];
}

class ChangeUserErrorState extends ChangeUserRoleState {
  final String message;

  const ChangeUserErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class DeleteUserLoadingState extends ChangeUserRoleState {
  @override
  List<Object> get props => [];
}

class DeleteUserSuccessState extends ChangeUserRoleState {
  final CreateEntity createEntity;

  const DeleteUserSuccessState({required this.createEntity});
  @override
  List<Object> get props => [createEntity];
}

class DeleteUserErrorState extends ChangeUserRoleState {
  final String message;

  const DeleteUserErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class SelectRoleLoadingState extends ChangeUserRoleState {
  @override
  List<Object> get props => [];
}

class SelectRoleState extends ChangeUserRoleState {
  @override
  List<Object> get props => [];
}
