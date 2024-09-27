part of 'tags_cubit.dart';

abstract class TagsState extends Equatable {
  const TagsState();
}

class TagsInitial extends TagsState {
  @override
  List<Object> get props => [];
}

class GetTagsLoadingState extends TagsState {
  @override
  List<Object> get props => [];
}

class GetTagsSuccessState extends TagsState {
  final TagsEntity allClinicsEntity;

  const GetTagsSuccessState({required this.allClinicsEntity});

  @override
  List<Object> get props => [allClinicsEntity];
}

class GetTagsErrorState extends TagsState {
  final String message;

  const GetTagsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
