import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:food_taste_app/Controller/Services/firebase_collections.dart';
import 'package:food_taste_app/Models/product_home_page_model_class.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:food_taste_app/View/Widgets/custom_grid_view.dart';
import 'package:food_taste_app/View/Widgets/custom_grid_view_shimmer.dart';
import 'package:food_taste_app/View/Widgets/custom_product_home_page_design.dart';

import '../../../../Controller/Provider/favorite_selected_button.dart';

class BurgerTabBar extends ConsumerStatefulWidget {
  const BurgerTabBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BurgerTabBarState();
}

class _BurgerTabBarState extends ConsumerState<BurgerTabBar> {
  ///**
  ///! Search a Current user Some time after using
  ///FirebaseAuth auth = FirebaseAuth.instance;
  ///User? user = FirebaseAuth.instance.currentUser;
  /// */

  // bool selectedFavoriteIcon = false;
  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    getBurgerFirebase();
  }

  Stream getBurgerFirebase() {
    return FirebaseAllCollection.burgerCollection
        // .where("userID",isEqualTo: user!.uid,)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    var selectProvider = ref.watch(favoriteSelectORNot);
    return Scaffold(
        backgroundColor: allScreenColor,
        body: StreamBuilder(
          stream: getBurgerFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CustomGridView(
                // Using Custom GridView
                itemCount: snapshot.data?.docs.length,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 300,
                    crossAxisSpacing: 2),
                itemBuilder: (p0, p1) => const CustomGridViewShimmer(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return CustomGridView(
                // Using Custom GridView
                itemCount: snapshot.data?.docs.length,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisExtent: 300),
                itemBuilder: (context, index) {
                  // Fetch firebase data Using ProductModelClass .
                  ProductHomePageModelClass product =
                      ProductHomePageModelClass.fromJson(
                          snapshot.data.docs[index].data());
                  return CustomProductHomePage(
                    image: product.imageUrl.toString(),
                    name: product.name.toString(),
                    price: product.price,
                    favoriteIcon: selectProvider
                        ? const Icon(Icons.favorite_border)
                        : const Icon(Icons.favorite),
                    favoriteOnPress: () {
                      if (selectProvider == false) {
                        ref.read(favoriteSelectORNot.notifier).update((state) {
                          return selectProvider = true;
                        });
                      } else {
                        ref.read(favoriteSelectORNot.notifier).update((state) {
                          return selectProvider = false;
                        });
                      }
                    },
                    onTap: () {
                      // Here this data transfer to next Screen .
                      Navigator.pushNamed(
                        context,
                        RoutesClassName.detailPage,
                        arguments: ProductHomePageModelClass(
                            imageUrl: product.imageUrl.toString(),
                            name: product.name.toString(),
                            price: product.price,
                            popularPremiumStar: ""),
                      );
                    },
                  );
                },
              );
            }
            return const Center(child: Text("No Data"));
          },
        ));
  }
}

/**
 *            !   This code Using StreamProvider member of RiverPod 
burgerData.when(
          data: (List<ProductModelClass> data) {
            return CustomGridView(
              // Using Custom GridView
              itemCount: burgerData.value!.length,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 2, mainAxisExtent: 300),
              itemBuilder: (context, index) {
                // Fetch firebase data Using ProductModelClass .
                // ProductModelClass product =
                //     ProductModelClass.fromJson(burgerData.value);
                return CustomProductHomePage(
                    image: data[index].imageUrl.toString(),
                    name: data[index].name.toString(),
                    price: data[index].price.toString());
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
              itemCount: burgerData.value?.length ?? 0,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 300, crossAxisSpacing: 2),
              itemBuilder: (p0, p1) => const CustomGridViewShimmer(),
            );
          },
        ) */