import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/Services/get_firebase_favorite_method.dart';
import 'package:food_taste_app/View/Screen/Favorite/favorite_widget.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/utility.dart';
import 'package:food_taste_app/View/Widgets/custom_favorite_shimmer_effect.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  FavoriteAllDataFetch getData = FavoriteAllDataFetch();

  // Firebase Services
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  // ! Delete Favorite Item
  Stream<void> deleteFavoriteItem({required String itemId}) {
    return firestore
        .collection("UserInfo")
        .doc(user!.uid)
        .collection("Favorite")
        .doc(itemId)
        .delete()
        .asStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: allScreenColor,
        body: SafeArea(
          child: FutureBuilder(
            future: getData.getAllDataFavoriteMethod(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomFavoritePageShimmer();
              } else if (snapshot.hasError) {
                return const Center(
                  child: AutoSizeText(
                    "No Found Favorite Page Data ",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    NameAndBackButton(
                        pageName: "Favorite",
                        icon: Icons.arrow_back,
                        itemCount: snapshot.data?.length),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (context, index) {
                          return FavoriteWidget(
                            imageUrl: snapshot.data![index].favoriteImageUrl
                                .toString(),
                            name: snapshot.data![index].favoriteName.toString(),
                            price: snapshot.data![index].favoritePrice,
                            // ! Delete Items
                            deleteFavorite: () {
                              deleteFavoriteItem(
                                  itemId: snapshot.data![index].favoriteID
                                      .toString());
                              //     .then((value) {
                              //   showMessageToast("Delete Favorite Item");
                              // });
                              // setState(() {});
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text("No Data "));
              }
            },
          ),
        ));
  }
}

/**
 * 
 */
