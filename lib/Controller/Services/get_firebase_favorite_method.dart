import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_taste_app/Models/favorite_button_model_class.dart';

class FavoriteAllDataFetch {
  // Firebase Services
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  FavoriteIconModelClass favoriteModel = FavoriteIconModelClass();
  // ays list ka andr all data a raha ha .
  List<FavoriteIconModelClass> favoriteList = [];

  Future<List<FavoriteIconModelClass>> getAllDataFavoriteMethod() async {
    List<FavoriteIconModelClass> newList = [];
    var getFavoriteData = await firestore
        .collection("UserInfo")
        .doc(user!.uid)
        .collection("Favorite")
        .get();

    for (var element in getFavoriteData.docs) {
      favoriteModel = FavoriteIconModelClass.fromJson(element.data());
      newList.add(favoriteModel);
    }
    favoriteList = newList;
    return favoriteList;
  }
}
