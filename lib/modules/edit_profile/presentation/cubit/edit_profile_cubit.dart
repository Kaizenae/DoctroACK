import 'package:dartz/dartz.dart';
import 'package:doctor_ack/modules/forget_password/domain/entities/general_entity.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

import '../../domain/use_cases/edit_profile_usecase.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  final EditProfileUsecase editProfileUsecase;
  EditProfileCubit({
    required this.editProfileUsecase,
  }) : super(InitEditProfileState());

  static EditProfileCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String name = '';
  String phone = '';
  String email = '';
  String? noId = '';
  String? image = '';

  ImagePicker imagePicker = ImagePicker();

  void changeImage(String imageBase) {
    image = imageBase;
    emit(ChangeImageState());
  }

  Future<void> editProfile() async {
    emit(EditProfileLoadingState());

    Either<Failure, GeneralEntity> response =
        await editProfileUsecase(EditProfileParams(
      image: image ?? '',
      userName: userNameController.text,
      phoneNumber: phoneNumberController.text,
      email: emailController.text,
    ));

    emit(response
        .fold((failure) => EditProfileErrorState(message: failure.message),
            (generalEntity) {
      return EditProfileSuccessState(generalEntity: generalEntity);
    }));
  }

  bool checkChanges() {
    if (userNameController.text != name ||
        phoneNumberController.text != phone ||
        emailController.text != email) {
      return false;
    } else {
      return true;
    }
  }
}
