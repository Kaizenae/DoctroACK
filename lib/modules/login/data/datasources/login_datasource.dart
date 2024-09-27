import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel> login({
    required String email,
    required String password,
  });
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  ApiConsumer apiConsumer;
  LoginRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiConsumer.post(EndPoints.loginUrl, body: {
      "jsonrpc": "2.0",
      "params": {
        "db": EndPoints.database,
        "email": email,
        "password": password,
      }
    });
    return LoginModel.fromJson(response);
  }
}
