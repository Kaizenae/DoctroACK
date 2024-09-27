import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/sales_model.dart';

abstract class SalesRemoteDataSource {
  Future<SalesModel> sales({
    required String filter,
    String? start,
    String? end,
  });
}

class SalesRemoteDataSourceImpl implements SalesRemoteDataSource {
  ApiConsumer apiConsumer;

  SalesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<SalesModel> sales({
    required String filter,
    String? start,
    String? end,
  }) async {
    final response = await apiConsumer.get(EndPoints.getSalesEndpoint, data: {
      "jsonrpc": "2.0",
      "params": {
        "filter": filter.isNotEmpty
            ? filter
            : {
                "custom": {"start": start!, "end": end!}
              }
      }
    });
    return SalesModel.fromJson(response);
  }
}
