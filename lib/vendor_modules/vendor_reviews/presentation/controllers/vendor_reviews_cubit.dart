import 'package:doctor_ack/languages/locale_keys.g.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import 'vendor_reviews_state.dart';

class VendorReviewsCubit extends Cubit<VendorReviewsState> {
  VendorReviewsCubit() : super(VendorReviewsInitial());

  static VendorReviewsCubit get(context) => BlocProvider.of(context);

  bool isPressed = false;
  int sortValue = 1;
  List<Map<String, dynamic>> sortModel = [
    {"name": LocaleKeys.newest, "id": 1},
    {"name": LocaleKeys.oldest, "id": 2},
    {
      "name": LocaleKeys.highRate,
      "id": 3,
    },
  ];
  List<Map<String, dynamic>> serviceFilterModel = [
    {"name": "All", "id": 1},
    {"name": "Botox", "id": 2},
    {
      "name": "Hair Removal",
      "id": 3,
    },
    {
      "name": "Medical",
      "id": 4,
    },
    {
      "name": "Beauty",
      "id": 5,
    },
  ];

  selectSort(int val) {
    emit(SelectSortLoadingState());
    sortValue = val;
    emit(SelectSortState());
  }
}
