import 'package:doctor_ack/modules/all_clinics/data/models/tags_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/all_clinics_model.dart';

abstract class AllClinicsRemoteDataSource {
  Future<AllClinicsModel> allClinics(
      {required String endpoint,
      required String sortBy,
      required int tagId,
      required double lat,
      required double long});

  Future<TagsModel> tags();
}

class AllClinicsRemoteDataSourceImpl implements AllClinicsRemoteDataSource {
  ApiConsumer apiConsumer;

  AllClinicsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<AllClinicsModel> allClinics(
      {required String endpoint,
      required String sortBy,
      required int tagId,
      required double lat,
      required double long}) async {
    EndPoints.baseUrl;

    final response = await apiConsumer.get(endpoint, data: {
      "params": sortBy == 'nearby'
          ? {
              "tag_id": tagId,
              "sort": sortBy,
              "latitude": lat,
              "longitude": long
            }
          : {"tag_id": tagId, "sort": sortBy}
    });

    return AllClinicsModel.fromJson(response);
  }

  @override
  Future<TagsModel> tags() async {
    final response =
        await apiConsumer.get(EndPoints.tagsEndpoint, data: {"params": {}});

    return TagsModel.fromJson(response);
  }
}
