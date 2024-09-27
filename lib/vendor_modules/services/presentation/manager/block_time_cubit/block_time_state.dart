part of 'block_time_cubit.dart';

abstract class BlockTimeState extends Equatable {
  const BlockTimeState();
}

class BlockTimeInitial extends BlockTimeState {
  @override
  List<Object> get props => [];
}

class BlockTimeLoadingState extends BlockTimeState {
  @override
  List<Object> get props => [];
}

class BlockTimeSuccessState extends BlockTimeState {
  final CreateEntity createEntity;

  const BlockTimeSuccessState({required this.createEntity});
  @override
  List<Object> get props => [];
}

class BlockTimeErrorState extends BlockTimeState {
  final String message;

  const BlockTimeErrorState({required this.message});
  @override
  List<Object> get props => [];
}
