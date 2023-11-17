import 'package:food_taste_app/Waste_Data/DataBase/favorite_db_helper_database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String databaseName = "favorite.db";
  static const int databaseVersion = 5;
  static Database? _database;

  static Future<Database> get databaseFavoriteFunction async {
    String directory = await getDatabasesPath();
    String path = join(directory, databaseName);
    return _database ??
        await openDatabase(path, version: databaseVersion,
            onCreate: (Database db, int version) {
          db.execute(FavoriteDbHelperClass.createTable);
        });
  }
}
