import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/categories_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoriesModel> categories();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  ApiConsumer apiConsumer;

  CategoriesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<CategoriesModel> categories() async {
    EndPoints.baseUrl;
    final response =
        await apiConsumer.get(EndPoints.getCategoriesEndpoint, data: {});
    return CategoriesModel.fromJson(response);
  }
}
