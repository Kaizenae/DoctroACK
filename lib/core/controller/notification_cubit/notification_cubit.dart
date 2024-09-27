import 'package:doctor_ack/core/controller/database_helper.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import 'package:sqflite/sqflite.dart';

import '../../general_models/notify_model.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  static NotificationCubit get(context) => BlocProvider.of(context);
  final Database _database = DatabaseHelper.database;

  Future<void> removeFromNotification(int itemId) async {
    emit(RemoveNotificationLoadingState());

    try {
      await _database.delete(
        'notification',
        where: 'id = ?',
        whereArgs: [itemId],
      );
      emit(RemoveNotificationSuccessState());
      await getNotificationItems();
      // ignore: empty_catches
    } catch (e) {}
  }

  getNotificationItems() async {
    emit(GetNotificationLoadingState());

    try {
      List<Map<String, dynamic>> result = await _database.query('notification');
      List<NotifyModel> notification = List.generate(result.length, (i) {
        return NotifyModel(
          id: result[i]['id'],
          title: result[i]['title'],
          body: result[i]['body'],
          time: result[i]['time'],
        );
      });

      emit(GetNotificationSuccessState(savedNotificationEntity: notification));
    } catch (e) {
      emit(GetNotificationErrorState(message: LocaleKeys.tryLater.tr()));
    }
  }
}
