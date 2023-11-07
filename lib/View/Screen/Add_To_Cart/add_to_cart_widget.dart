// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../../Widgets/Components/Constant/colors.dart';
import '../../Widgets/Components/Constant/utility.dart';
import '../../Widgets/custom_size_box.dart';

// !App Bar Cart Name and Cart items
class NameAndBackButton extends StatelessWidget {
  const NameAndBackButton(
      {super.key,
      required this.pageName,
      required this.icon,
      required this.itemCount});
  final String pageName;
  final IconData icon;
  final int? itemCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            icon,
            color: iconColor,
            size: 30,
          ),
        ),
        AutoSizeText(
          pageName,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        AutoSizeText("${itemCount.toString()}\titem",
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cutive(
                textStyle: const TextStyle(
              fontSize: 12,
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ))),
      ],
    );
  }
}

// ! Cart Item Design .
class CartShowItem extends StatefulWidget {
  CartShowItem(
      {super.key,
      required this.image,
      required this.cartItemName,
      required this.cartItemPrice,
      required this.deleteIconOnTap});
  final Image image;
  final String cartItemName;
  // ignore: prefer_typing_uninitialized_variables
  var cartItemPrice;
  final void Function()? deleteIconOnTap;
  @override
  State<CartShowItem> createState() => _CartShowItemState();
}

class _CartShowItemState extends State<CartShowItem> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * 0.15,
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
        child: Row(
          children: [
            //
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: widget.image),
              ),
            ),
            const CustomSizedBox(
              widthRatio: 0.02,
            ),
            //
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShimmerEffect(
                      baseColor: Colors.white,
                      highlightColor: const Color.fromARGB(255, 250, 168, 162),
                      child: productNameText(
                          name: widget.cartItemName, fontSize: 25)),
                  ShimmerEffect(
                    baseColor: Colors.white,
                    highlightColor: const Color.fromARGB(255, 250, 168, 162),
                    child: productPriceText(
                      price: "${widget.cartItemPrice}",
                    ),
                  ),
                ],
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: widget.deleteIconOnTap,
                      child: const Icon(
                        CupertinoIcons.bin_xmark_fill,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
