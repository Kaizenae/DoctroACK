import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/reviews_entity.dart';
import '../../domain/repositories/reviews_repository.dart';
import '../data_sources/reviews_remote_datasource.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final NetworkInfo networkInfo;
  final ReviewsRemoteDataSource reviewsRemoteDataSource;

  ReviewsRepositoryImpl(
      {required this.networkInfo, required this.reviewsRemoteDataSource});

  @override
  Future<Either<Failure, ReviewsEntity>> reviews(ReviewsParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await reviewsRemoteDataSource.reviews(
            clinicID: params.clinicID,
            filter: params.filter,
            isClinic: params.isClinic);
        if (remoteEmployee.resultEntity.status == true) {
          return Right(remoteEmployee);
        } else {
          return Left(Failure(400, remoteEmployee.resultEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CreateEntity>> createReviews(
      CreateReviewsParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await reviewsRemoteDataSource.createReviews(
            serviceID: params.serviceID, rate: params.rate, note: params.note);
        if (remoteEmployee.resultEntity.status == true) {
          return Right(remoteEmployee);
        } else {
          return Left(Failure(400, remoteEmployee.resultEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
