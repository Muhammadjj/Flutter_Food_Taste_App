import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Models/add_to_cart_model.dart';
import 'package:food_taste_app/View/Screen/Add_To_Cart/add_to_cart_widget.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/utility.dart';
import 'package:food_taste_app/View/Widgets/shining_button.dart';

class AddToCartScreen extends ConsumerStatefulWidget {
  const AddToCartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddToCartScreenState();
}

class _AddToCartScreenState extends ConsumerState<AddToCartScreen> {
  // Firebase Services
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  AddCartModelClass cartModelClass = AddCartModelClass();

  List<AddCartModelClass> addToCartList = [];

// ** GetData Details Screen and Show AddToCart Screen .
  Future<List<AddCartModelClass>> getAddToCartData() async {
    List<AddCartModelClass> newList = [];
    var getData = await firestore
        .collection("UserInfo")
        .doc(user!.uid)
        .collection("YourCart")
        .get();

    for (var element in getData.docs) {
      cartModelClass = AddCartModelClass.fromMap(element.data());
      newList.add(cartModelClass);
      debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>....  $newList");
    }
    addToCartList = newList;
    debugPrint("....................${addToCartList.length}");

    return addToCartList;
  }

// Press delete icon and delete list of item one by one .
  Future<void> deleteItem({required String itemId}) {
    return firestore
        .collection("UserInfo")
        .doc(user!.uid)
        .collection("YourCart")
        .doc(itemId)
        .delete();
  }

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    getAddToCartData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: allScreenColor,
      body: FutureBuilder(
        future: getAddToCartData(),
        builder: (context, AsyncSnapshot<List<AddCartModelClass>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.hasError.toString()));
          } else if (snapshot.hasData) {
            // ! Fetch Firebase item data .
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    NameAndBackButton(
                        pageName: "CART",
                        icon: CupertinoIcons.arrow_left,
                        itemCount: snapshot.data?.length ?? 0),
                    // ! show Items
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return CartShowItem(
                              image: Image(
                                  image: NetworkImage(snapshot
                                      .data![index].cartImageUrl
                                      .toString())),
                              cartItemName:
                                  snapshot.data![index].cartName.toString(),
                              cartItemPrice: snapshot.data![index].cartPrice,
                              // !Delete Item Cards Working .
                              deleteIconOnTap: () {
                                deleteItem(
                                    itemId: snapshot.data![index].cartUid
                                        .toString());
                                setState(() {});
                              },
                            );
                          }),
                    ),
                    //! Working of total item price and location button
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(1, 0.0),
                              color: Colors.white,
                              blurRadius: 3,
                              blurStyle: BlurStyle.outer,
                              spreadRadius: 2),
                        ],
                        color: const Color.fromARGB(255, 56, 57, 66),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Total price item
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                productNameText(name: "Total"),
                                productNameText(name: "470Rs"),
                              ],
                            ),
                            // Next Working Buttons .
                            FoodTasteShineButton(
                              color: const Color.fromARGB(255, 255, 71, 76),
                              height: height * 0.08,
                              width: width * 0.8,
                              firstLinearGradientColors:
                                  const Color.fromARGB(255, 255, 64, 71),
                              secondLinearGradientColors:
                                  const Color.fromARGB(143, 253, 86, 86)
                                      .withOpacity(0.7),
                              child:
                                  buttonTextSizeAndFont(text: "FINAL PROCESS"),
                              onTap: () {},
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(
              child: Text(
            "No Data",
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ));
        },
      ),
    );
  }
}
