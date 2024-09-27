import 'package:equatable/equatable.dart';

import '../../../domain/entities/banks_entity.dart';

abstract class BanksState extends Equatable {
  const BanksState();
}

class BanksInitial extends BanksState {
  @override
  List<Object> get props => [];
}

class GetBanksLoadingState extends BanksState {
  @override
  List<Object> get props => [];
}

class GetBanksSuccessState extends BanksState {
  final BanksEntity banksEntity;

  const GetBanksSuccessState({required this.banksEntity});
  @override
  List<Object> get props => [banksEntity];
}

class GetBanksErrorState extends BanksState {
  final String message;

  const GetBanksErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
