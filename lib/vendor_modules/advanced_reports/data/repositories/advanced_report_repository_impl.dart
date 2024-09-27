import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/domain/entities/top_services_entity.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/advanced_customers_entity.dart';
import '../../domain/entities/advanced_sales_entity.dart';
import '../../domain/repositories/advanced_report_repository.dart';
import '../data_sources/advanced_report_remote_datasource.dart';

class AdvancedReportRepositoryImpl implements AdvancedReportRepository {
  final NetworkInfo networkInfo;
  final AdvancedReportDataSource advancedReportRemoteDataSource;

  AdvancedReportRepositoryImpl(
      {required this.networkInfo,
      required this.advancedReportRemoteDataSource});

  @override
  Future<Either<Failure, AdvancedSalesEntity>> advancedSales(params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile =
            await advancedReportRemoteDataSource.advancedSales(
          filter: params.filter,
          sort: params.sort,
          serviceId: params.serviceId,
        );
        if (remoteProfile.resultEntity.status) {
          return Right(remoteProfile);
        } else {
          showToast1(message: 'message', type: MessageType.error);
          return Left(Failure(400, 'Get Profile Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AdvancedCustomersEntity>> advancedCustomers(
      params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile =
            await advancedReportRemoteDataSource.advancedCustomers(
          filter: params.filter,
          sort: params.sort,
          serviceId: params.serviceId,
        );
        if (remoteProfile.resultEntity.status) {
          return Right(remoteProfile);
        } else {
          return Left(Failure(400, 'Get Profile Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, TopServicesEntity>> topServices(
      NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile =
            await advancedReportRemoteDataSource.topServices();
        if (remoteProfile.resultEntity.status) {
          return Right(remoteProfile);
        } else {
          return Left(Failure(400, 'Get Profile Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
