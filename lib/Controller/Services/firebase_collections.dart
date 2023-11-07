import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAllCollection {
  // !  User  Type Data .
  // ** UserAll Types of Related Information Data Collections.
  static CollectionReference<Map<String, dynamic>> firestoreUserData =
      FirebaseFirestore.instance.collection("UserInfo");
  // ** User All SignUp Page Types of Images Collections.
  static CollectionReference<Map<String, dynamic>> firestoreUserInfoImage =
      FirebaseFirestore.instance.collection("UserInfoImage");

  // ! Tab Bar Grid View All Data Receive Firebase FireStore .
  // ** Burger Collection
  static CollectionReference<Map<String, dynamic>> burgerCollection =
      FirebaseFirestore.instance.collection("Burger");
  // ** Fried Collection
  static CollectionReference<Map<String, dynamic>> friedCollection =
      FirebaseFirestore.instance.collection("Fried");
  // ** IceCream Collection
  static CollectionReference<Map<String, dynamic>> iceCreamCollection =
      FirebaseFirestore.instance.collection("IceCream");
  // ** Cake Collection
  static CollectionReference<Map<String, dynamic>> cakeCollection =
      FirebaseFirestore.instance.collection("Cake");

  // ! Popular Page Collections.
  static CollectionReference<Map<String, dynamic>> popularPageCollection =
      FirebaseFirestore.instance.collection("Popular_Page");
}
