import 'package:doctor_ack/core/general_models/notify_model.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class AddNotificationLoadingState extends NotificationState {
  @override
  List<Object> get props => [];
}

class AddNotificationSuccessState extends NotificationState {
  @override
  List<Object> get props => [];
}

class RemoveNotificationLoadingState extends NotificationState {
  @override
  List<Object> get props => [];
}

class RemoveNotificationSuccessState extends NotificationState {
  @override
  List<Object> get props => [];
}

class GetNotificationLoadingState extends NotificationState {
  @override
  List<Object> get props => [];
}

class GetNotificationSuccessState extends NotificationState {
  final List<NotifyModel> savedNotificationEntity;

  const GetNotificationSuccessState({required this.savedNotificationEntity});

  @override
  List<Object> get props => [];
}

class GetNotificationErrorState extends NotificationState {
  final String message;

  const GetNotificationErrorState({required this.message});

  @override
  List<Object> get props => [];
}
