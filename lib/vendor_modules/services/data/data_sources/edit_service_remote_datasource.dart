import 'package:doctor_ack/core/general_models/create_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';

abstract class EditServiceRemoteDataSource {
  Future<CreateModel> editService({
    required int serviceID,
    required String name,
    required String about,
    required String logo,
    required double price,
  });
}

class EditServiceRemoteDataSourceImpl implements EditServiceRemoteDataSource {
  ApiConsumer apiConsumer;

  EditServiceRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<CreateModel> editService({
    required int serviceID,
    required String name,
    required String about,
    required String logo,
    required double price,
  }) async {
    final response =
        await apiConsumer.post(EndPoints.editServiceEndpoint, body: {
      "params": {
        "service_id": serviceID,
        "name": name,
        "about": about,
        "service_price": price,
        "logo": logo,
      }
    });
    return CreateModel.fromJson(response);
  }
}
