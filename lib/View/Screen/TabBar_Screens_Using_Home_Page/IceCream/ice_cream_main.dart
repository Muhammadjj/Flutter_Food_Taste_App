import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/Provider/tab_bar_firebase_data_provider.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import '../../../../Models/product_home_page_model_class.dart';
import '../../../Widgets/custom_grid_view.dart';
import '../../../Widgets/custom_grid_view_shimmer.dart';
import '../../../Widgets/custom_product_home_page_design.dart';

class UnknownPage extends ConsumerStatefulWidget {
  const UnknownPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UnknownPageState();
}

class _UnknownPageState extends ConsumerState<UnknownPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final iceCreamProvider = ref
        .watch(TabBarAllDataFirebaseProvider.getIceCreamDataFireStoreProvider);

    return Scaffold(
        backgroundColor: allScreenColor,
        body: iceCreamProvider.when(
          data: (List<ProductHomePageModelClass> data) {
            return CustomGridView(
              // Using Custom GridView
              itemCount: iceCreamProvider.value!.length,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 2, mainAxisExtent: 300),
              itemBuilder: (context, index) {
                // Fetch firebase data Using ProductModelClass .
                var images = data[index].imageUrl.toString();
                var names = data[index].name.toString();
                var prices = data[index].price;
                return CustomProductHomePage(
                  // Hero Tag .
                  productImageHeroTag: images,
                  // Firebase Data .
                  image: images,
                  name: names,
                  price: prices,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesClassName.detailPage,
                        arguments: ProductHomePageModelClass(
                            imageUrl: images,
                            name: names,
                            price: prices,
                            popularPremiumStar: ""));
                  },
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(
                error.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
          loading: () {
            return CustomGridView(
              // Using Custom GridView
              itemCount: iceCreamProvider.value?.length ?? 0,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 300, crossAxisSpacing: 2),
              itemBuilder: (p0, p1) => const CustomGridViewShimmer(),
            );
          },
        ));
  }
}
