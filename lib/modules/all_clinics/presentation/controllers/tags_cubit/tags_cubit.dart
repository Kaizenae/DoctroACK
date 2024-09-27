import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entities/tags_entity.dart';
import '../../../domain/use_cases/all_clinics_usecase.dart';
part 'tags_state.dart';

class TagsCubit extends Cubit<TagsState> {
  final TagsUsecase tagsUsecase;
  TagsCubit({required this.tagsUsecase}) : super(TagsInitial());
  static TagsCubit get(context) => BlocProvider.of(context);

  Future<void> getTags() async {
    emit(GetTagsLoadingState());
    Either<Failure, TagsEntity> response = await tagsUsecase(NoParams());

    emit(response.fold(
        (failure) => GetTagsErrorState(message: failure.message),
        (allClinicsEntity) =>
            GetTagsSuccessState(allClinicsEntity: allClinicsEntity)));
  }
}
