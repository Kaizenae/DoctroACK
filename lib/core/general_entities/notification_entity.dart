import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final int success;
  final int failure;

  const NotificationEntity({required this.success, required this.failure});

  @override
  List<Object> get props => [success, failure];
}
