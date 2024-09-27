import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../core/error/failure.dart';
import '../../../vendor_clinic/domain/use_cases/clinic_profile_usecase.dart';
import 'clinic_state.dart';

class EditClinicCubit extends Cubit<EditClinicState> {
  final EditClinicProfileUsecase editClinicProfileUsecase;

  EditClinicCubit({
    required this.editClinicProfileUsecase,
  }) : super(EditClinicInitial());

  static EditClinicCubit get(context) => BlocProvider.of(context);
  ImagePicker imagePicker = ImagePicker();
  ImagePicker imagePickerCover = ImagePicker();

  void changeImage(String imageBase) {
    image = imageBase;
    emit(ChangeImageState());
  }

  void changeImageCover(String imageBase) {
    imageCover = imageBase;
    emit(ChangeImageCoverState());
  }

  String image = '';
  String imageCover = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController expertiseController = TextEditingController();
  TextEditingController experienceController = TextEditingController();

  Future<void> editClinicProfile() async {
    emit(EditClinicProfileLoadingState());

    Either<Failure, CreateEntity> response = await editClinicProfileUsecase(
        EditClinicProfileParams(
            logo: image,
            cover: imageCover,
            name: nameController.text,
            street: streetController.text,
            city: cityController.text,
            stateId: int.parse(stateController.text),
            phoneNumber: phoneController.text,
            expertise: expertiseController.text,
            experience: int.parse(experienceController.text),
            about: aboutController.text));

    emit(response.fold(
        (failure) => EditClinicProfileErrorState(message: failure.message),
        (createEntity) {
      return EditClinicProfileSuccessState(createEntity: createEntity);
    }));
  }

  GlobalKey<FormState> formKeyBank = GlobalKey<FormState>();
  String bankNameController = '';
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController holderNameController = TextEditingController();
  String currencyController = '';
}
