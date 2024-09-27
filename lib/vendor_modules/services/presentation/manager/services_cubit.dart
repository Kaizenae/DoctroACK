import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/general_entities/create_entity.dart';
import '../../../../languages/locale_keys.g.dart';
import '../../domain/use_cases/edit_service_usecase.dart';
import 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final EditServiceUsecase editServiceUsecase;

  ServicesCubit({required this.editServiceUsecase}) : super(ServicesInitial());

  static ServicesCubit get(context) => BlocProvider.of(context);

  String image = '';
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Future<void> editService() async {
    emit(EditServiceLoadingState());

    Either<Failure, CreateEntity> response = await editServiceUsecase(
        EditServiceParams(
            serviceId: serviceID,
            logo: image,
            price: double.parse(priceController.text),
            name: nameController.text,
            about: aboutController.text));

    emit(response
        .fold((failure) => EditServiceErrorState(message: failure.message),
            (createEntity) {
      return EditServiceSuccessState(createEntity: createEntity);
    }));
  }

  int serviceID = 0;

  ImagePicker imagePicker = ImagePicker();

  void changeImage(String imageBase) {
    image = imageBase;
    emit(ChangeImageState());
  }

  int sortValue = 1;
  int filterValue = 1;
  List<Map<String, dynamic>> sortModel = [
    {"name": LocaleKeys.priceHighLow, "id": 1},
    {"name": LocaleKeys.priceLowHigh, "id": 2},
    {"name": LocaleKeys.newest, "id": 3},
    {"name": LocaleKeys.oldest, "id": 4},
    {"name": LocaleKeys.highRate, "id": 5},
  ];
  List<Map<String, dynamic>> serviceFilterModel = [
    {"name": "All", "id": 1},
    {"name": "Botox", "id": 2},
    {
      "name": "Hair Removal",
      "id": 3,
    },
    {
      "name": "Medical",
      "id": 4,
    },
    {
      "name": "Beauty",
      "id": 5,
    },
  ];

  selectSort(int val) {
    emit(SelectSortLoadingState());
    sortValue = val;
    emit(SelectSortState());
  }

  selectFilter(int val) {
    emit(SelectFilterLoadingState());
    filterValue = val;
    emit(SelectFilterState());
  }
}
