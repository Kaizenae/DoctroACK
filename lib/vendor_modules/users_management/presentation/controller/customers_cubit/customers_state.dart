import 'package:doctor_ack/vendor_modules/users_management/domain/entities/customers_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CustomersState extends Equatable {
  const CustomersState();
}

class CustomersInitial extends CustomersState {
  @override
  List<Object> get props => [];
}

class GetCustomersLoadingState extends CustomersState {
  @override
  List<Object> get props => [];
}

class GetCustomersSuccessState extends CustomersState {
  final CustomersEntity customersEntity;

  const GetCustomersSuccessState({required this.customersEntity});
  @override
  List<Object> get props => [customersEntity];
}

class GetCustomersErrorState extends CustomersState {
  final String message;

  const GetCustomersErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
