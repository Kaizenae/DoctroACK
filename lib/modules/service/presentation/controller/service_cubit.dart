import 'package:dartz/dartz.dart';
import 'package:doctor_ack/modules/service/presentation/controller/service_state.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/use_cases/service_usecase.dart';

class ServiceCubit extends Cubit<ServiceState> {
  final ServiceUsecase serviceUsecase;

  ServiceCubit({required this.serviceUsecase}) : super(ServiceClinicInitial());

  static ServiceCubit get(context) => BlocProvider.of(context);
  String selectedValue = 'Sudden Illness';
  int serviceID = 0;
  int maxScheduleDays = 0;
  String serviceName = '';
  int doctorID = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Future<void> getService() async {
    emit(GetServiceLoadingState());
    Either<Failure, ServiceEntity> response =
        await serviceUsecase(ClinicParams(clinicID: serviceID));
    refreshController.refreshCompleted();

    emit(response.fold(
        (failure) => GetServiceErrorState(message: failure.message),
        (serviceEntity) =>
            GetServiceSuccessState(serviceEntity: serviceEntity)));
  }

  String buttonName = '';

  String selectedCancelValue = 'Sudden Illness';

  List<Map<String, dynamic>> serviceCancelModel = [
    {"id": 1, "name": 'Sudden Illness'},
    {"id": 2, "name": 'Emergency'},
    {"id": 3, "name": 'Unforeseen Work Commitments'},
    {"id": 4, "name": 'Personal or Family Obligations'},
    {"id": 5, "name": 'Conflicting Appointments'},
    {"id": 6, "name": 'Other'},
  ];

  // selectSort(int val) {
  //   emit(const SelectSortLoadingState());
  //   selectedValue = val;
  //   print(selectedValue);
  //   emit(SelectSortState());
  // }

  selectCancel(String val) {
    emit(SelectCancelLoadingState());
    selectedCancelValue = val;
    emit(SelectCancelState());
  }

  List<DateTime> blockDates(int numOfDays) {
    List<DateTime> next7Days = [];
    DateTime currentDate = DateTime.now();

    DateTime dateAfter7Days = currentDate.add(Duration(days: numOfDays));

    for (int i = 0; i < 365; i++) {
      DateTime nextWeekDates = dateAfter7Days.add(Duration(days: i));
      DateFormat('yyyy-MM-dd').format(nextWeekDates);
      next7Days.add(nextWeekDates);
    }
    for (int i = 365; i > 0; i--) {
      DateTime lastYearDates = DateTime.now().subtract(Duration(days: i));
      DateFormat('yyyy-MM-dd').format(lastYearDates);
      next7Days.add(lastYearDates);
    }

    return next7Days;
  }
  // List<DateTime> getLast365Days() {
  //
  //   for (int i = 365; i >= 0; i--) {
  //     DateTime currentDate = DateTime.now().add(Duration(days: i));
  //     print(currentDate);
  //     print('*************************');
  //     String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
  //     next7Days.add(currentDate);
  //   }
  //
  //
  //
  //   return next7Days;
  // }
}
