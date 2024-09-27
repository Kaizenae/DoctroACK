import 'package:equatable/equatable.dart';

import '../../../domain/entities/offer_entity.dart';

abstract class OfferState extends Equatable {
  const OfferState();
}

class OfferInitial extends OfferState {
  @override
  List<Object> get props => [];
}

class GetOfferLoadingState extends OfferState {
  @override
  List<Object> get props => [];
}

class GetOfferSuccessState extends OfferState {
  final OfferEntity offerEntity;

  const GetOfferSuccessState({required this.offerEntity});

  @override
  List<Object> get props => [offerEntity];
}

class GetOfferErrorState extends OfferState {
  final String message;

  const GetOfferErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
