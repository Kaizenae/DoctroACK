part of 'all_featured_clinics_cubit.dart';

abstract class AllFeaturedClinicsState extends Equatable {
  const AllFeaturedClinicsState();
}

class ClinicInitial extends AllFeaturedClinicsState {
  @override
  List<Object> get props => [];
}

class GetAllFeaturedClinicsLoadingState extends AllFeaturedClinicsState {
  @override
  List<Object> get props => [];
}

class GetAllFeaturedClinicsSuccessState extends AllFeaturedClinicsState {
  final AllClinicsEntity allClinicsEntity;

  const GetAllFeaturedClinicsSuccessState({required this.allClinicsEntity});

  @override
  List<Object> get props => [allClinicsEntity];
}

class GetAllFeaturedClinicsErrorState extends AllFeaturedClinicsState {
  final String message;

  const GetAllFeaturedClinicsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SelectSortLoadingState extends AllFeaturedClinicsState {
  @override
  List<Object> get props => [];
}

class SelectSortState extends AllFeaturedClinicsState {
  @override
  List<Object> get props => [];
}
