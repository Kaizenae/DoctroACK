part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();
}

class LocationInitial extends LocationState {
  @override
  List<Object> get props => [];
}

class CheckGPSLoadingState extends LocationState {
  @override
  List<Object> get props => [];
}

class CheckGPSState extends LocationState {
  @override
  List<Object> get props => [];
}

class GetLocationLoadingState extends LocationState {
  @override
  List<Object> get props => [];
}

class GetLocationState extends LocationState {
  @override
  List<Object> get props => [];
}

class UpdateLocationPosition extends LocationState {
  @override
  List<Object> get props => [];
}
