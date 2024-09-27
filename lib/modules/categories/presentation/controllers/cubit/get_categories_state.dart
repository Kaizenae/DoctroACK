import 'package:doctor_ack/modules/categories/domain/entities/categories_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CategoriesStates extends Equatable {}

class InitCategoriesState extends CategoriesStates {
  @override
  List<Object> get props => [];
}

class GetCategoriesLoadingState extends CategoriesStates {
  @override
  List<Object> get props => [];
}

class GetCategoriesSuccessState extends CategoriesStates {
  final CategoriesEntity categoriesEntity;

  GetCategoriesSuccessState({required this.categoriesEntity});

  @override
  List<Object> get props => [categoriesEntity];
}

class GetCategoriesErrorState extends CategoriesStates {
  final String message;

  GetCategoriesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
