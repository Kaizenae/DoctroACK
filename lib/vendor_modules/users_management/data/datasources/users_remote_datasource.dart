import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/general_models/create_model.dart';
import '../models/customers_model.dart';
import '../models/users_model.dart';

abstract class UsersRemoteDataSource {
  Future<UsersModel> users();
  Future<CustomersModel> customers();
  Future<CreateModel> changeUserRole(
      {required int userId, required String role});
  Future<CreateModel> deleteUser({
    required int userId,
  });
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  ApiConsumer apiConsumer;

  UsersRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<UsersModel> users() async {
    final response = await apiConsumer.get(EndPoints.getUsersEndpoint,
        data: {"jsonrpc": "2.0", "params": {}});
    return UsersModel.fromJson(response);
  }

  @override
  Future<CustomersModel> customers() async {
    final response = await apiConsumer.get(EndPoints.getCustomersEndpoint,
        data: {"jsonrpc": "2.0", "params": {}});
    return CustomersModel.fromJson(response);
  }

  @override
  Future<CreateModel> changeUserRole(
      {required int userId, required String role}) async {
    final response =
        await apiConsumer.post(EndPoints.changeUserRoleEndpoint, body: {
      "jsonrpc": "2.0",
      "params": {
        "user_id": userId,
        "role": role
        //manager , doctor ,admin
      }
    });
    return CreateModel.fromJson(response);
  }

  @override
  Future<CreateModel> deleteUser({required int userId}) async {
    final response =
        await apiConsumer.post(EndPoints.deleteUserEndpoint, body: {
      "jsonrpc": "2.0",
      "params": {"user_id": userId}
    });
    return CreateModel.fromJson(response);
  }
}
