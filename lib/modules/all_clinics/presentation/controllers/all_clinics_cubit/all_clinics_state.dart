part of 'all_clinics_cubit.dart';

abstract class AllClinicsState extends Equatable {
  const AllClinicsState();
}

class ClinicInitial extends AllClinicsState {
  @override
  List<Object> get props => [];
}

class SelectSortLoadingState extends AllClinicsState {
  @override
  List<Object> get props => [];
}

class SelectSortState extends AllClinicsState {
  @override
  List<Object> get props => [];
}

class ClearSortState extends AllClinicsState {
  @override
  List<Object> get props => [];
}

class SelectFilterLoadingState extends AllClinicsState {
  @override
  List<Object> get props => [];
}

class SelectFilterState extends AllClinicsState {
  @override
  List<Object> get props => [];
}

class GetAllClinicsLoadingState extends AllClinicsState {
  @override
  List<Object> get props => [];
}

class GetAllClinicsSuccessState extends AllClinicsState {
  final AllClinicsEntity allClinicsEntity;

  const GetAllClinicsSuccessState({required this.allClinicsEntity});

  @override
  List<Object> get props => [allClinicsEntity];
}

class GetAllClinicsErrorState extends AllClinicsState {
  final String message;

  const GetAllClinicsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
