part of 'contact_us_cubit.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();
}

class ContactUsInitial extends ContactUsState {
  @override
  List<Object> get props => [];
}

class ContactUsLoadingState extends ContactUsState {
  @override
  List<Object> get props => [];
}

class ContactUsSuccessState extends ContactUsState {
  final GeneralEntity generalEntity;

  const ContactUsSuccessState({required this.generalEntity});

  @override
  List<Object> get props => [generalEntity];
}

class ContactUsErrorState extends ContactUsState {
  final String message;

  const ContactUsErrorState({required this.message});

  @override
  List<Object> get props => [];
}
