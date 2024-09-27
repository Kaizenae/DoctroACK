import 'package:equatable/equatable.dart';

import '../../../domain/entities/top_services_entity.dart';

abstract class TopServicesState extends Equatable {
  const TopServicesState();
}

class TopServicesInitial extends TopServicesState {
  @override
  List<Object> get props => [];
}

class GetTopServicesLoadingState extends TopServicesState {
  @override
  List<Object> get props => [];
}

class GetTopServicesSuccessState extends TopServicesState {
  final TopServicesEntity topServicesEntity;

  const GetTopServicesSuccessState({required this.topServicesEntity});
  @override
  List<Object> get props => [topServicesEntity];
}

class GetTopServicesErrorState extends TopServicesState {
  final String message;

  const GetTopServicesErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
