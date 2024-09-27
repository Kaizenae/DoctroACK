import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/finances_model.dart';

abstract class FinancesRemoteDataSource {
  Future<FinancesModel> finances();
}

class FinancesRemoteDataSourceImpl implements FinancesRemoteDataSource {
  ApiConsumer apiConsumer;

  FinancesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<FinancesModel> finances() async {
    final response = await apiConsumer.get(EndPoints.getFinancesEndpoint,
        data: {"jsonrpc": "2.0", "params": {}});
    return FinancesModel.fromJson(response);
  }
}
