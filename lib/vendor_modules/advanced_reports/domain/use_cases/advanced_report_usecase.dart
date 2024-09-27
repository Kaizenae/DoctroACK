import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/advanced_customers_entity.dart';
import '../entities/advanced_sales_entity.dart';
import '../entities/top_services_entity.dart';
import '../repositories/advanced_report_repository.dart';

class AdvancedSalesUsecase
    implements UseCase<AdvancedSalesEntity, AdvancedReportParams> {
  final AdvancedReportRepository advancedReportRepository;

  AdvancedSalesUsecase(this.advancedReportRepository);

  @override
  Future<Either<Failure, AdvancedSalesEntity>> call(
          AdvancedReportParams params) =>
      advancedReportRepository.advancedSales(params);
}

class AdvancedCustomersUsecase
    implements UseCase<AdvancedCustomersEntity, AdvancedReportParams> {
  final AdvancedReportRepository advancedReportRepository;

  AdvancedCustomersUsecase(this.advancedReportRepository);

  @override
  Future<Either<Failure, AdvancedCustomersEntity>> call(
          AdvancedReportParams params) =>
      advancedReportRepository.advancedCustomers(params);
}

class TopServicesUsecase implements UseCase<TopServicesEntity, NoParams> {
  final AdvancedReportRepository advancedReportRepository;

  TopServicesUsecase(this.advancedReportRepository);

  @override
  Future<Either<Failure, TopServicesEntity>> call(NoParams params) =>
      advancedReportRepository.topServices(params);
}
