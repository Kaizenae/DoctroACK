import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/modules/categories/domain/entities/categories_entity.dart';
import 'package:doctor_ack/modules/categories/domain/use_cases/categories_usecase.dart';
import '../../../../../core/error/failure.dart';
import 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<CategoriesStates> {
  final CategoriesUsecase categoriesUsecase;

  GetCategoriesCubit({
    required this.categoriesUsecase,
  }) : super(InitCategoriesState());

  static GetCategoriesCubit get(context) => BlocProvider.of(context);

  String id = '';

  Future<void> getCategories() async {
    emit(GetCategoriesLoadingState());
    Either<Failure, CategoriesEntity> response =
        await categoriesUsecase(NoParams());

    emit(response.fold(
        (failure) => GetCategoriesErrorState(message: failure.message),
        (categoriesEntity) =>
            GetCategoriesSuccessState(categoriesEntity: categoriesEntity)));
  }

  imageConverter(String image) {
    return const Base64Decoder().convert(image);
  }
}
