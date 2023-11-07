import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/Services/firebase_collections.dart';
import 'package:food_taste_app/Models/product_home_page_model_class.dart';

class PopularFirebaseGetData {
  static final getPopularData =
      StreamProvider<List<ProductHomePageModelClass>>((ref) async* {
    final popularData = FirebaseAllCollection.popularPageCollection
        .snapshots()
        .map((event) => event.docs
            .map((snapShot) =>
                ProductHomePageModelClass.fromJson(snapShot.data()))
            .toList());
    yield* popularData;
  });
}
