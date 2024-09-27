import '../../../../core/api/api_consumer.dart';
import '../models/all_services_model.dart';

abstract class AllServicesRemoteDataSource {
  Future<AllServicesModel> allClinics({
    required String endpoint,
    required String sortBy,
    required int categoryId,
    required int clinicId,
  });
}

class AllServicesRemoteDataSourceImpl implements AllServicesRemoteDataSource {
  ApiConsumer apiConsumer;

  AllServicesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<AllServicesModel> allClinics({
    required String endpoint,
    required String sortBy,
    required int categoryId,
    required int clinicId,
  }) async {
    final response = await apiConsumer.get(endpoint, data: {
      "params": {
        "sort": sortBy,
        "category_id": categoryId,
        "clinic_id": clinicId
      }
    });

    return AllServicesModel.fromJson(response);
  }
}
