import 'package:doctor_ack/modules/profile/domain/entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class GetProfileLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class GetProfileSuccessState extends ProfileState {
  final ProfileEntity profileEntity;

  const GetProfileSuccessState({required this.profileEntity});
  @override
  List<Object> get props => [profileEntity];
}

class GetProfileErrorState extends ProfileState {
  final String message;

  const GetProfileErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class LogoutState extends ProfileState {
  @override
  List<Object> get props => [];
}
