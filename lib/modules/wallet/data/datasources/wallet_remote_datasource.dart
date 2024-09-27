import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/wallet_model.dart';

abstract class WalletRemoteDataSource {
  Future<WalletModel> wallet();
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  ApiConsumer apiConsumer;

  WalletRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<WalletModel> wallet() async {
    final response = await apiConsumer.get(EndPoints.getWalletEndpoint,
        data: {"jsonrpc": "2.0", "params": {}});
    return WalletModel.fromJson(response);
  }
}
