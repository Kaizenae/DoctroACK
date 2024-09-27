import 'package:doctor_ack/vendor_modules/users_management/domain/entities/users_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UserManagementState extends Equatable {
  const UserManagementState();
}

class UserManagementInitial extends UserManagementState {
  @override
  List<Object> get props => [];
}

class GetUsersLoadingState extends UserManagementState {
  @override
  List<Object> get props => [];
}

class GetUsersSuccessState extends UserManagementState {
  final UsersEntity usersEntity;

  const GetUsersSuccessState({required this.usersEntity});
  @override
  List<Object> get props => [usersEntity];
}

class GetUsersErrorState extends UserManagementState {
  final String message;

  const GetUsersErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
