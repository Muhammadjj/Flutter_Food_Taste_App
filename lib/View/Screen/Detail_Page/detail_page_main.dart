import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Models/add_to_cart_model.dart';
import 'package:food_taste_app/Models/product_home_page_model_class.dart';
import 'package:food_taste_app/View/Screen/Detail_Page/detail_page_widget.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/utility.dart';
import 'package:food_taste_app/View/Widgets/shining_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../../Widgets/custom_size_box.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage(
    this.modelClass, {
    super.key,
  });
  final ProductHomePageModelClass modelClass;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  // Starting value of Products and using this value increment and
  // decrement method .
  var initialValue = 1;
  int plusValue = 1;
  double multiplyValue = 2.0;

  // Firebase Services .
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: allScreenColor,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(12.0),
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              // ! Image And Floating Button Section .
              CartButtonAndImage(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    image: NetworkImage(
                      widget.modelClass.imageUrl.toString(),
                    ),
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                  ),
                ),
              ),

              const CustomSizedBox(
                heightRatio: 0.03,
              ),
              // ! Name and Price Section .
              Container(
                // height: height * 0.2,
                width: width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 56, 57, 66),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(1, 0.0),
                        color: Colors.white,
                        blurRadius: 3,
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 2),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShimmerEffect(
                              baseColor: Colors.white,
                              highlightColor:
                                  const Color.fromARGB(255, 250, 168, 162),
                              child: productNameText(
                                  name: widget.modelClass.name.toString(),
                                  fontSize: 30)),
                          // ** Product Current Price .
                          ShimmerEffect(
                              baseColor: Colors.white,
                              highlightColor:
                                  const Color.fromARGB(255, 250, 168, 162),
                              child: productPriceText(
                                  price: widget.modelClass.price!
                                      .toStringAsFixed(1),
                                  fontSize: 25))
                        ],
                      ),
                      const CustomSizedBox(
                        heightRatio: 0.02,
                      ),
                      ReadMoreText(
                        descriptionText,
                        numLines: 2,
                        readMoreText: "More",
                        readLessText: "Less",
                        readMoreTextStyle: const TextStyle(color: textColor),
                        readMoreIconColor: iconColor,
                        style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          // overflow: TextOverflow.ellipsis
                        )),
                      ),
                    ],
                  ),
                ),
              ),

              const CustomSizedBox(
                heightRatio: 0.03,
              ),

              // ! Text Decrement and Increment Number  .
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    widget.modelClass.popularPremiumStar.toString(),
                    style: GoogleFonts.cambo(
                        textStyle: const TextStyle(
                      fontSize: 17,
                      color: Colors.amber,
                      shadows: [Shadow(color: Colors.black, blurRadius: 5)],
                      fontWeight: FontWeight.bold,
                    )),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton.small(
                        onPressed: increment,
                        backgroundColor: iconColor,
                        child: const Icon(
                          CupertinoIcons.plus_app_fill,
                          color: Color.fromARGB(255, 255, 84, 85),
                        ),
                      ),
                      const CustomSizedBox(
                        widthRatio: 0.01,
                      ),
                      // Text
                      AutoSizeText(
                        "$initialValue",
                        style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const CustomSizedBox(widthRatio: 0.01),
                      FloatingActionButton.small(
                        onPressed: decrement,
                        backgroundColor: iconColor,
                        child: const Icon(
                          CupertinoIcons.minus_rectangle_fill,
                          size: 20,
                          color: Color.fromARGB(255, 255, 84, 85),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const CustomSizedBox(
                heightRatio: 0.02,
              ),

              //  ! ADD TO CART BUTTON .
              FoodTasteShineButton(
                color: const Color.fromARGB(255, 255, 71, 76),
                height: height * 0.08,
                width: width * 0.8,
                firstLinearGradientColors:
                    const Color.fromARGB(255, 255, 64, 71),
                secondLinearGradientColors:
                    const Color.fromARGB(143, 253, 86, 86).withOpacity(0.7),
                child: buttonTextSizeAndFont(text: "ADD TO CART"),

                /// hm ny separate sa ak modle class bnye js ma hm apna
                /// (AddToCard) ka data store krwa raha ha .
                onTap: () {
                  var dataAndTimeCurrentUid =
                      DateTime.now().microsecondsSinceEpoch.toString();
                  AddCartModelClass cartModel = AddCartModelClass();
                  cartModel.cartUid = "$dataAndTimeCurrentUid${user!.uid}";
                  cartModel.cartImageUrl = widget.modelClass.imageUrl;
                  cartModel.cartName = widget.modelClass.name;
                  cartModel.cartPrice = widget.modelClass.price;

                  firestore
                      .collection("UserInfo")
                      .doc(user!.uid)
                      .collection("YourCart")
                      .doc("$dataAndTimeCurrentUid${user!.uid}")
                      .set(cartModel.toMap())
                      .then((value) {
                    // Flutter Toast .
                    showMessageToast("Add To Card");
                  });
                },
              ),
            ],
          ),
        ));
  }

//  **
  void incrementValue() {
    widget.modelClass.price = widget.modelClass.price;
    setState(() {
      initialValue++;
      widget.modelClass.price =
          (widget.modelClass.price! / plusValue++) * multiplyValue++;
    });
  }

  void increment() {
    widget.modelClass.price = widget.modelClass.price;
    setState(() {
      initialValue++;
      widget.modelClass.price = widget.modelClass.price! * 2.0;
    });
  }

  void decrementValue() {
    setState(() {
      if (initialValue >= 2 && initialValue != 0) {
        initialValue--;
        widget.modelClass.price =
            (widget.modelClass.price! / multiplyValue) / plusValue;
      }
    });
  }

  void decrement() {
    setState(() {
      if (initialValue >= 2 && initialValue != 0) {
        initialValue--;
        widget.modelClass.price = widget.modelClass.price! / 2.0;
      }
    });
  }
}
