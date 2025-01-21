import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entities/search_services_entity.dart';
import '../../../domain/use_cases/search_services_usecase.dart';

part 'search_services_state.dart';

class SearchServicesCubit extends Cubit<SearchServicesState> {
  final SearchServicesUsecase searchServicesUsecase;
  SearchServicesCubit({
    required this.searchServicesUsecase,
  }) : super(SearchServicesInitial());

  static SearchServicesCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  bool recent = true;
  void changeRecent(bool isRecent) {
    emit(ChangeRecentLoadingState());
    recent = isRecent;
    emit(ChangeRecentSuccessState());
  }

  Future<void> getSearchServices() async {
    emit(GetSearchServicesLoadingState());
    Either<Failure, SearchServicesEntity> response =
        await searchServicesUsecase(
            StringParams(string: searchController.text, email: ""));

    emit(response.fold(
        (failure) => GetSearchServicesErrorState(message: failure.message),
        (searchServicesEntity) => GetSearchServicesSuccessState(
            searchServicesEntity: searchServicesEntity)));
  }

//   @override
//   Future<void> close() {
// searchController.dispose();
// return super.close();
//   }
}
