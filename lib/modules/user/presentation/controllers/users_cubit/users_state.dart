import 'package:doctor_ack/core/general_entities/notification_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../forget_password/domain/entities/general_entity.dart';

abstract class UsersStates extends Equatable {}

class InitialUsersState extends UsersStates {
  @override
  List<Object> get props => [];
}

class UpdateNoTokenLoading extends UsersStates {
  @override
  List<Object> get props => [];
}

class UpdateNoTokenSuccess extends UsersStates {
  final GeneralEntity createEntity;

  UpdateNoTokenSuccess({required this.createEntity});
  @override
  List<Object> get props => [createEntity];
}

class UpdateNoTokenError extends UsersStates {
  final String message;

  UpdateNoTokenError({required this.message});
  @override
  List<Object> get props => [message];
}

class DeleteUserAccountLoading extends UsersStates {
  @override
  List<Object> get props => [];
}

class DeleteUserAccountSuccess extends UsersStates {
  final GeneralEntity createEntity;

  DeleteUserAccountSuccess({required this.createEntity});
  @override
  List<Object> get props => [createEntity];
}

class DeleteUserAccountError extends UsersStates {
  final String message;

  DeleteUserAccountError({required this.message});
  @override
  List<Object> get props => [message];
}

class SendNotificationLoading extends UsersStates {
  @override
  List<Object> get props => [];
}

class SendNotificationSuccess extends UsersStates {
  final NotificationEntity notificationEntity;

  SendNotificationSuccess({required this.notificationEntity});
  @override
  List<Object> get props => [notificationEntity];
}

class SendNotificationError extends UsersStates {
  final String message;

  SendNotificationError({required this.message});
  @override
  List<Object> get props => [message];
}
