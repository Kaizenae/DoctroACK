import 'package:dartz/dartz.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/domain/entities/top_services_entity.dart';
import '../../domain/entities/advanced_customers_entity.dart';
import '../../domain/entities/advanced_sales_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

abstract class AdvancedReportRepository {
  Future<Either<Failure, AdvancedSalesEntity>> advancedSales(
      AdvancedReportParams params);
  Future<Either<Failure, AdvancedCustomersEntity>> advancedCustomers(
      AdvancedReportParams params);
  Future<Either<Failure, TopServicesEntity>> topServices(NoParams params);
}
