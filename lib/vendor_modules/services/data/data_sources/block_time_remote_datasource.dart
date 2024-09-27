import 'package:doctor_ack/core/general_models/create_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';

abstract class BlockTimeRemoteDataSource {
  Future<CreateModel> blockTime({
    required int serviceID,
    required String date,
    required String time,
  });
}

class BlockTimeRemoteDataSourceImpl implements BlockTimeRemoteDataSource {
  ApiConsumer apiConsumer;

  BlockTimeRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<CreateModel> blockTime({
    required int serviceID,
    required String date,
    required String time,
  }) async {
    final response = await apiConsumer.post(EndPoints.blockTimeEndpoint, body: {
      "params": {
        "service_id": serviceID,
        "date": date,
        "time": time,
      }
    });
    return CreateModel.fromJson(response);
  }
}
