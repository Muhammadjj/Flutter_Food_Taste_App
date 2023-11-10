import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/DataBase/favorite_db_helper_database.dart';
import 'package:food_taste_app/Models/favorite_button_model_class.dart';
import 'package:food_taste_app/View/Screen/Favorite/widget.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  FavoriteDbHelperClass dbHelperClass = FavoriteDbHelperClass();

  List<FavoriteIconModelClass> emptyList = [];

  // Future<dynamic> getDatabaseAllData() async {
  //   emptyList = await dbHelperClass.getAllDatabase();
  //   setState(() {});
  // }

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    viewData();
  }

  Future<List<FavoriteIconModelClass>> viewData() async {
    emptyList = await dbHelperClass.getAllDatabase();
    // setState(() {});
    return emptyList;
  }

  // @override
  // void didChangeDependencies() async {
  //   // Todo: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: viewData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("No Data"));
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return FavoriteWidget(
                  imageUrl: emptyList[index].favoriteImageUrl.toString(),
                  name: emptyList[index].favoriteName.toString(),
                  price: emptyList[index].favoritePrice);
            },
          );
        } else {
          return const Center(child: Text("No Data "));
        }
      },
    ));
  }
}

/**
 * ListView.builder(
        itemCount: emptyList.length,
        itemBuilder: (context, index) {
          return FavoriteWidget(
              imageUrl: emptyList[index].favoriteImageUrl.toString(),
              name: emptyList[index].favoriteName.toString(),
              price: emptyList[index].favoritePrice);
        },
      ),
 */