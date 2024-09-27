import 'package:doctor_ack/vendor_modules/home/domain/entities/sales_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SalesState extends Equatable {
  const SalesState();
}

class SalesInitial extends SalesState {
  @override
  List<Object> get props => [];
}

class GetSalesLoadingState extends SalesState {
  @override
  List<Object> get props => [];
}

class GetSalesSuccessState extends SalesState {
  final SalesEntity salesEntity;

  const GetSalesSuccessState({required this.salesEntity});
  @override
  List<Object> get props => [salesEntity];
}

class GetSalesErrorState extends SalesState {
  final String message;

  const GetSalesErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
