part of 'all_services_cubit.dart';

abstract class AllServicesState extends Equatable {
  const AllServicesState();
}

class ClinicInitial extends AllServicesState {
  @override
  List<Object> get props => [];
}

class GetAllServicesLoadingState extends AllServicesState {
  @override
  List<Object> get props => [];
}

class GetAllServicesSuccessState extends AllServicesState {
  final AllServicesEntity allClinicsEntity;

  const GetAllServicesSuccessState({required this.allClinicsEntity});

  @override
  List<Object> get props => [allClinicsEntity];
}

class GetAllServicesErrorState extends AllServicesState {
  final String message;

  const GetAllServicesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SelectSortLoadingState extends AllServicesState {
  @override
  List<Object> get props => [];
}

class SelectSortState extends AllServicesState {
  @override
  List<Object> get props => [];
}

class SelectFilterLoadingState extends AllServicesState {
  @override
  List<Object> get props => [];
}

class SelectFilterState extends AllServicesState {
  @override
  List<Object> get props => [];
}

class ClearFilterState extends AllServicesState {
  @override
  List<Object> get props => [];
}
