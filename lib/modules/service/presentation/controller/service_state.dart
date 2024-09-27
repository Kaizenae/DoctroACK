import 'package:doctor_ack/modules/service/domain/entities/service_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();
}

class ServiceClinicInitial extends ServiceState {
  @override
  List<Object> get props => [];
}

class GetServiceLoadingState extends ServiceState {
  @override
  List<Object> get props => [];
}

class GetServiceSuccessState extends ServiceState {
  final ServiceEntity serviceEntity;

  const GetServiceSuccessState({required this.serviceEntity});
  @override
  List<Object> get props => [serviceEntity];
}

class GetServiceErrorState extends ServiceState {
  final String message;

  const GetServiceErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SelectSortLoadingState extends ServiceState {
  const SelectSortLoadingState();
  @override
  List<Object> get props => [];
}

class SelectSortState extends ServiceState {
  @override
  List<Object> get props => [];
}

class SelectCancelLoadingState extends ServiceState {
  @override
  List<Object> get props => [];
}

class SelectCancelState extends ServiceState {
  @override
  List<Object> get props => [];
}
