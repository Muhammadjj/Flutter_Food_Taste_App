// !App Bar Cart Name and Cart items
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import '../../Widgets/Components/Constant/utility.dart';

class OderNowCustomAppBar extends StatelessWidget {
  const OderNowCustomAppBar(
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

// ! OrderNow Design Item Design .
class CartShowItem extends StatefulWidget {
  const CartShowItem({
    super.key,
    // this.image,
    // this.orderProductName,
    // this.orderItemPrice,
    required this.orderCustomerName,
    required this.orderPhoneNo,
    required this.orderAddress,
    required this.orderPostal,
    required this.deleteOrderNow,
  });
  // final String? image;
  // final String? orderProductName;
  // final num? orderItemPrice;
  final String orderCustomerName;
  final String orderPhoneNo;
  final String orderAddress;
  final String orderPostal;
  final void Function() deleteOrderNow;

  @override
  State<CartShowItem> createState() => _CartShowItemState();
}

class _CartShowItemState extends State<CartShowItem> {
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: height * 0.15,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded(
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: SizedBox(
              //       height: height * 0.15,
              //       width: width * 0.4,
              //       child: Image(
              //           image: NetworkImage(
              //             widget.image!,
              //           ),
              //           fit: BoxFit.fill),
              //     ),
              //   ),
              // ),
              // productNameText(
              //     name: "Food Name:\t\t${widget.orderProductName}",
              //     fontSize: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  productNameText(
                      name: "User Name: \t\t${widget.orderCustomerName}",
                      fontSize: 15),
                  IconButton(
                      onPressed: widget.deleteOrderNow,
                      icon: const Icon(
                        Icons.delete_forever,
                        color: iconColor,
                      ))
                ],
              ),
              productNameText(
                  name: "Phone No: \t\t ${widget.orderPhoneNo}", fontSize: 15),
              productNameText(
                  name: "Post Code: \t\t${widget.orderPostal}", fontSize: 15),
              productNameText(
                  name: "Address: \t\t ${widget.orderAddress}", fontSize: 15),
            ],
          ),
        ),
      ),
    );
  }
}
