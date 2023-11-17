import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/utility.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/Components/Constant/colors.dart';

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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
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
      ),
    );
  }
}

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.deleteFavorite,
  });
  final String imageUrl;
  final String name;
  final num? price;
  final void Function()? deleteFavorite;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        height: height * 0.3,
        width: width * 0.7,
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
              // ! delete Icons .
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: deleteFavorite,
                  icon: const Icon(Icons.delete_forever),
                  color: iconColor,
                ),
              ),
              // ! Image .
              Expanded(
                child: SizedBox(
                  height: height * 0.15,
                  width: width * 0.7,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  productNameText(name: name, fontSize: 30),
                  productPriceText(price: price.toString(), fontSize: 25)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
