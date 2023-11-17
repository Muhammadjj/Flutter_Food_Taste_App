import 'package:food_taste_app/Waste_Data/DataBase/favorite_db_provider_database.dart';
import 'package:food_taste_app/Models/favorite_button_model_class.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDbHelperClass {
  static const String favoriteDbName = "Favorite";
  static const String columID = "favoriteID";
  static const String columImage = "favoriteImageUrl";
  static const String columName = "favoriteName";
  static const String columPrice = "favoritePrice";
  static const String createTable =
      """CREATE TABLE $favoriteDbName($columID TEXT PRIMARY KEY ,$columName TEXT, $columImage TEXT, $columPrice INTEGER )""";

  // ! Database insert function
  Future<bool> databaseInsert({FavoriteIconModelClass? modelClass}) async {
    Database db = await DatabaseProvider.databaseFavoriteFunction;
    int result = await db.insert(favoriteDbName, modelClass!.toMap());
    return result == 1;
  }

  // ! Database fetch/get function
  Future<List<FavoriteIconModelClass>> getAllDatabase() async {
    Database db = await DatabaseProvider.databaseFavoriteFunction;
    List<Map<String, dynamic>> list = await db.query(favoriteDbName);
    return list.map((data) => FavoriteIconModelClass.fromJson(data)).toList();
  }
}
