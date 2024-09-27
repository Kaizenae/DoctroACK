import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/general_models/create_model.dart';
import '../models/favourite_model.dart';

abstract class FavouriteRemoteDataSource {
  Future<FavouriteModel> favourite();

  Future<CreateModel> addRemoveFavourite(
      {required int id, required bool isClinic, required String endpoint});
}

class FavouriteRemoteDataSourceImpl implements FavouriteRemoteDataSource {
  ApiConsumer apiConsumer;

  FavouriteRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<FavouriteModel> favourite() async {
    final response =
        await apiConsumer.get(EndPoints.getFavouritesEndpoint, data: {});

    return FavouriteModel.fromJson(response);
  }

  @override
  Future<CreateModel> addRemoveFavourite(
      {required int id,
      required bool isClinic,
      required String endpoint}) async {
    final response = await apiConsumer.post(endpoint, body: {
      "params": {"id": id, "is_clinic": isClinic}
    });

    return CreateModel.fromJson(response);
  }
}
