import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:food_taste_app/Models/product_home_page_model_class.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/utility.dart';
import 'package:food_taste_app/View/Widgets/decorated_text_field.dart';

class SearchBarPage extends ConsumerStatefulWidget {
  const SearchBarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends ConsumerState<SearchBarPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  String? searchQuery;
  List<Map<String, dynamic>> searchResults = [];

  Stream getSearchBarFirebaseData() {
    return firestore
        .collection("Popular_Page")
        .where("name", isGreaterThanOrEqualTo: searchQuery)
        .where("name", isLessThan: "${searchQuery}z")
        .get()
        .then((querySnapshot) {
      setState(() {
        searchResults = querySnapshot.docs.map((doc) => doc.data()).toList();
      });
    }).asStream();
  }

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    getSearchBarFirebaseData();
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: allScreenColor,
        appBar: AppBar(
          backgroundColor: allScreenColor,
          title: productNameText(name: "Food Search", fontSize: 30),
          centerTitle: true,
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              // ! Blur Text Form Field
              BlurTextField(
                width: width * 0.95,
                controller: searchController,
                hintText: "Search for a food Name ",
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: iconColor,
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                onFieldSubmitted: (value) {
                  getSearchBarFirebaseData();
                },
              ),

              // ! List of searching data Processing.
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return searchResults.isEmpty
                        ? const Center(
                            child: Text("data"),
                          )
                        : Card(
                            elevation: 8,
                            color: const Color.fromARGB(255, 56, 57, 66),
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(
                                    color: Colors.white.withOpacity(0.2))),
                            child: ListTile(
                              // ! Hero Tag
                              leading: Hero(
                                tag: searchResults[index]["imageUrl"],
                                child: Image(
                                    image: NetworkImage(
                                        searchResults[index]["imageUrl"])),
                              ),
                              title: productNameText(
                                  name: searchResults[index]['name']),
                              subtitle: productPriceText(
                                  price:
                                      searchResults[index]['price'].toString()),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesClassName.detailPage,
                                    arguments: ProductHomePageModelClass(
                                        imageUrl: searchResults[index]
                                            ["imageUrl"],
                                        name: searchResults[index]["name"],
                                        price: searchResults[index]["price"],
                                        popularPremiumStar: "Premium"));
                              },
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
