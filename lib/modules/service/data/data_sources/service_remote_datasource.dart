import 'dart:developer';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/service_model.dart';

abstract class ServiceRemoteDataSource {
  Future<ServiceModel> service({required int clinicID});
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  ApiConsumer apiConsumer;

  ServiceRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ServiceModel> service({required int clinicID}) async {
    final response = await apiConsumer.get(EndPoints.getServiceEndpoint, data: {
      "params": {"service_id": clinicID}
    });
    log("response start");
    log(response.toString());
    log("response end");
    return ServiceModel.fromJson(response);
  }
}
