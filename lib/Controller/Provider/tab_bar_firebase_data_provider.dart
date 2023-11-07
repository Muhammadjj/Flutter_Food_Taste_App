import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/Services/firebase_collections.dart';
import 'package:food_taste_app/Models/product_home_page_model_class.dart';

class TabBarAllDataFirebaseProvider {
// ** IceCream .
  static final getIceCreamDataFireStoreProvider =
      StreamProvider<List<ProductHomePageModelClass>>((ref) async* {
    final getIceCreamData = FirebaseAllCollection.iceCreamCollection
        // .where("uids", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) => event.docs
            .map((snapShot) =>
                ProductHomePageModelClass.fromJson(snapShot.data()))
            .toList());
    yield* getIceCreamData;
  });

// ** Cake .
  static final getCakeDataFireStoreProvider =
      StreamProvider<List<ProductHomePageModelClass>>((ref) async* {
    final getCakeData = FirebaseAllCollection.cakeCollection
        // .where("uids", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) => event.docs
            .map((snapShot) =>
                ProductHomePageModelClass.fromJson(snapShot.data()))
            .toList());
    yield* getCakeData;
  });
}
