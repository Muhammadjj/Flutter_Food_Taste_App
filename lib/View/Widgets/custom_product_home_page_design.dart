import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/utility.dart';
import 'package:food_taste_app/View/Widgets/custom_size_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

class CustomProductHomePage extends ConsumerStatefulWidget {
  const CustomProductHomePage(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      this.favoriteOnPress,
      this.favoriteIcon = const Icon(Icons.favorite),
      this.onTap});

  final String image;
  final String name;
  final num? price;
  final void Function()? favoriteOnPress;
  final Widget favoriteIcon;
  final GestureTapCallback? onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomProductHomePageState();
}

class _CustomProductHomePageState extends ConsumerState<CustomProductHomePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: height * 0.1,
        width: width * 0.3,
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
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: widget.onTap,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ! Favorite Icon Section
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      color: Colors.red,
                      splashColor: Colors.white,
                      onPressed: widget.favoriteOnPress,
                      icon: widget.favoriteIcon)),
              // image Section
              Expanded(
                flex: 4,
                child: CustomSizedBox(
                  widthRatio: width * 0.2,
                  child: Image(
                    image: NetworkImage(
                      widget.image,
                    ),
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text("data"));
                    },
                  ),
                ),
              ),
              // ! Product Name Section
              Expanded(
                child: ShimmerEffect(
                  baseColor: Colors.white,
                  highlightColor: const Color.fromARGB(255, 250, 168, 162),
                  child: productNameText(name: widget.name),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      "USD:",
                      style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                              fontSize: 23,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 1)
                              ],
                              overflow: TextOverflow.ellipsis)),
                    ),
                    // ! Product price Section
                    AutoSizeText(widget.price.toString(),
                        style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                        overflow: TextOverflow.ellipsis)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



/**
 * Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(alignment: Alignment.center, children: [
        // Container(
        //   color: Colors.red,
        //   height: 200,
        //   width: 160,
        // ),
        Positioned(
          child: Container(
            margin: const EdgeInsets.only(top: 60),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(1, 0.0),
                    color: Colors.white,
                    blurRadius: 2.5,
                    blurStyle: BlurStyle.outer,
                    spreadRadius: 2),
              ],
              color: const Color.fromARGB(255, 56, 57, 66),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(name), Text(price)],
            ),
          ),
        ),
        Positioned(
          child: Container(
            margin: const EdgeInsets.only(bottom: 60),
            height: 150,
            width: 150,
            child: Image(image: NetworkImage(image), fit: BoxFit.fill),
          ),
        ),
      ]),
    );
 */
