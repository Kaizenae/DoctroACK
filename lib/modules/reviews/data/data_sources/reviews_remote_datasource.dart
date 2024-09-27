import 'package:doctor_ack/core/general_models/create_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/reviews_model.dart';

abstract class ReviewsRemoteDataSource {
  Future<ReviewsModel> reviews(
      {required int clinicID, required bool isClinic, required int filter});

  Future<CreateModel> createReviews({
    required int serviceID,
    required String rate,
    required String note,
  });
}

class ReviewsRemoteDataSourceImpl implements ReviewsRemoteDataSource {
  ApiConsumer apiConsumer;

  ReviewsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ReviewsModel> reviews(
      {required int clinicID,
      required bool isClinic,
      required int filter}) async {
    final response = await apiConsumer.get(
        isClinic
            ? EndPoints.getReviewsEndpoint
            : EndPoints.getServiceReviewsEndpoint,
        data: isClinic
            ? {
                "params": {"clinic_id": clinicID, "filter": filter}
              }
            : {
                "params": {"service_id": clinicID, "filter": filter}
              });

    return ReviewsModel.fromJson(response);
  }

  @override
  Future<CreateModel> createReviews(
      {required int serviceID,
      required String rate,
      required String note}) async {
    final response =
        await apiConsumer.post(EndPoints.createReviewsEndpoint, body: {
      "params": {"service_id": serviceID, "rate": rate, "description": note}
    });

    return CreateModel.fromJson(response);
  }
}
