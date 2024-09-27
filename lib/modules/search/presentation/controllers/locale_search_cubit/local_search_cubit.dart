// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'local_search_state.dart';

class LocalSearchCubit extends Cubit<LocalSearchState> {
  LocalSearchCubit() : super(LocalSearchInitial());
  static LocalSearchCubit get(context) => BlocProvider.of(context);
  Database? _database;

  Future<void> initDatabase() async {
    _database ??= await _initDatabase();
    await getSearchItems();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'search.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE search(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT
          )
        ''');
      },
    );
  }

  Future<void> addToSearch(SavedSearchEntity item) async {
    emit(AddSearchLoadingState());

    try {
      List<Map<String, dynamic>> result =
          await _database?.query('search') ?? [];
      List<SavedSearchEntity> search = result.map((item) {
        return SavedSearchEntity(
          id: item['id'],
          name: item['name'],
        );
      }).toList();
      bool isItemAddedBefore =
          search.contains((SavedSearchEntity(name: item.name)));

      if (!isItemAddedBefore) {
        await _database?.insert(
          'search',
          {
            'name': item.name,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        emit(AddSearchSuccessState());
      }

      await getSearchItems();
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> removeFromSearch(int itemId) async {
    emit(RemoveSearchLoadingState());

    try {
      await _database?.delete(
        'search',
        where: 'id = ?',
        whereArgs: [itemId],
      );
      emit(RemoveSearchSuccessState());
      await getSearchItems();
      // ignore: empty_catches
    } catch (e) {}
  }

  getSearchItems() async {
    emit(GetSearchLoadingState());

    try {
      List<Map<String, dynamic>> result =
          await _database?.query('search') ?? [];
      List<SavedSearchEntity> search = result.map((item) {
        return SavedSearchEntity(
          id: item['id'],
          name: item['name'],
        );
      }).toList();

      emit(GetSearchSuccessState(savedSearchEntity: search));
    } catch (e) {
      return [];
    }
  }
}

class SavedSearchEntity extends Equatable {
  final int? id;
  final String name;

  const SavedSearchEntity({this.id, required this.name});
  // Override the == operator to compare SavedSearchEntity objects based on their id
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedSearchEntity &&
          runtimeType == other.runtimeType &&
          name == other.name;

  // Override the hashCode to be consistent with the overridden ==
  @override
  int get hashCode => name.hashCode;
  @override
  List<Object> get props => [name];
}
