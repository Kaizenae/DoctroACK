import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../forget_password/domain/entities/general_entity.dart';
import '../../domain/use_cases/contact_us_usecase.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final ContactUsUsecase contactUsUsecase;
  ContactUsCubit({required this.contactUsUsecase}) : super(ContactUsInitial());

  static ContactUsCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> contactUsFun() async {
    emit(ContactUsLoadingState());

    Either<Failure, GeneralEntity> response =
        await contactUsUsecase(ContactUsParams(
      name: nameController.text,
      message: messageController.text,
      email: emailController.text,
      subject: subjectController.text,
    ));

    emit(response
        .fold((failure) => ContactUsErrorState(message: failure.message),
            (generalEntity) {
      emailController.clear();
      nameController.clear();
      messageController.clear();
      formKey.currentState!.reset();
      return ContactUsSuccessState(generalEntity: generalEntity);
    }));
  }
}
