part of 'search_services_cubit.dart';

abstract class SearchServicesState extends Equatable {
  const SearchServicesState();
}

class SearchServicesInitial extends SearchServicesState {
  @override
  List<Object> get props => [];
}

class ChangeRecentLoadingState extends SearchServicesState {
  @override
  List<Object> get props => [];
}

class ChangeRecentSuccessState extends SearchServicesState {
  @override
  List<Object> get props => [];
}

class GetSearchServicesLoadingState extends SearchServicesState {
  @override
  List<Object> get props => [];
}

class GetSearchServicesSuccessState extends SearchServicesState {
  final SearchServicesEntity searchServicesEntity;

  const GetSearchServicesSuccessState({required this.searchServicesEntity});

  @override
  List<Object> get props => [searchServicesEntity];
}

class GetSearchServicesErrorState extends SearchServicesState {
  final String message;

  const GetSearchServicesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
