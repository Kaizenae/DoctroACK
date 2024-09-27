import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CreateReviewsState extends Equatable {
  const CreateReviewsState();
}

class CreateReviewsInitial extends CreateReviewsState {
  @override
  List<Object> get props => [];
}

class CreateReviewsLoadingState extends CreateReviewsState {
  @override
  List<Object> get props => [];
}

class CreateReviewsSuccessState extends CreateReviewsState {
  final CreateEntity createEntity;

  const CreateReviewsSuccessState({required this.createEntity});

  @override
  List<Object> get props => [createEntity];
}

class CreateReviewsErrorState extends CreateReviewsState {
  final String message;

  const CreateReviewsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SelectSortLoadingState extends CreateReviewsState {
  @override
  List<Object> get props => [];
}

class SelectSortState extends CreateReviewsState {
  @override
  List<Object> get props => [];
}
