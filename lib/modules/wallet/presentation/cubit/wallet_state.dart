import 'package:equatable/equatable.dart';

import '../../domain/entities/wallet_entity.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletInitial extends WalletState {
  @override
  List<Object> get props => [];
}

class GetWalletLoadingState extends WalletState {
  @override
  List<Object> get props => [];
}

class GetWalletSuccessState extends WalletState {
  final WalletEntity walletEntity;

  const GetWalletSuccessState({required this.walletEntity});
  @override
  List<Object> get props => [walletEntity];
}

class GetWalletErrorState extends WalletState {
  final String message;

  const GetWalletErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class LogoutState extends WalletState {
  @override
  List<Object> get props => [];
}
