import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/register_model.dart';

abstract class RegisterRemoteDataSource {
  Future<RegisterModel> register({
    required String email,
    required String userName,
    required String phoneNumber,
    required String password,
  });
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  ApiConsumer apiConsumer;

  RegisterRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<RegisterModel> register({
    required String email,
    required String userName,
    required String phoneNumber,
    required String password,
  }) async {
    final response = await apiConsumer.post(EndPoints.registerUrl, body: {
      "jsonrpc": "2.0",
      "params": {
        "userName": userName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
      }
    });
    return RegisterModel.fromJson(response);
  }
}
