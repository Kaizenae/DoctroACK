import 'package:equatable/equatable.dart';

import 'local_search_cubit.dart';

abstract class LocalSearchState extends Equatable {
  const LocalSearchState();
}

class LocalSearchInitial extends LocalSearchState {
  @override
  List<Object> get props => [];
}

class AddSearchLoadingState extends LocalSearchState {
  @override
  List<Object> get props => [];
}

class AddSearchSuccessState extends LocalSearchState {
  @override
  List<Object> get props => [];
}

class RemoveSearchLoadingState extends LocalSearchState {
  @override
  List<Object> get props => [];
}

class RemoveSearchSuccessState extends LocalSearchState {
  @override
  List<Object> get props => [];
}

class GetSearchLoadingState extends LocalSearchState {
  @override
  List<Object> get props => [];
}

class GetSearchSuccessState extends LocalSearchState {
  final List<SavedSearchEntity> savedSearchEntity;

  const GetSearchSuccessState({required this.savedSearchEntity});

  @override
  List<Object> get props => [];
}
