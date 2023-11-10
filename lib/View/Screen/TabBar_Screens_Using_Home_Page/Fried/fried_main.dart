import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:food_taste_app/Controller/Services/firebase_collections.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';

import '../../../../Models/product_home_page_model_class.dart';
import '../../../Widgets/custom_grid_view.dart';
import '../../../Widgets/custom_grid_view_shimmer.dart';
import '../../../Widgets/custom_product_home_page_design.dart';

class FriedPage extends ConsumerStatefulWidget {
  const FriedPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriedPageState();
}

class _FriedPageState extends ConsumerState<FriedPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    getFriedFireStore();
  }

  Stream getFriedFireStore() {
    return FirebaseAllCollection.friedCollection
        // .where("userID", isEqualTo: user!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: allScreenColor,
        body: StreamBuilder(
          stream: getFriedFireStore(),
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
                itemBuilder: (context, index) => const CustomGridViewShimmer(),
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
                  var images = product.imageUrl.toString();
                  var names = product.name.toString();
                  var prices = product.price;
                  return CustomProductHomePage(
                    // Hero Tag
                    productImageHeroTag: images,
                    // Firebase Data
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
            }
            return const Center(child: Text("No Data"));
          },
        ));
  }
}
