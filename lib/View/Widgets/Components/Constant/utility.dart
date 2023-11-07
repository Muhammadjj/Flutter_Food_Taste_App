// ignore_for_file: unused_local_variable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

/// ** SnackBar Section
void showCommonSnackBar(BuildContext context,
    {required String text,
    DismissDirection dismissDirection = DismissDirection.down}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: const Color.fromARGB(255, 255, 87, 93),
    duration: const Duration(seconds: 2),
    dismissDirection: dismissDirection,
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
  ));
}

/// ! Show Flutter Toast
void showMessageToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.pink,
      textColor: Colors.white,
      fontSize: 10.0);
}

/// ! Images Section
const String backgroundImage = "asset/images/background.webp";
const String backgroundImage1 = "asset/images/background1.png";
const String connectivity = "asset/images/connectivity.png";
const String back =
    "https://firebasestorage.googleapis.com/v0/b/food-taste-app-5a86f.appspot.com/o/UserInfoImage%2F.jpg?alt=media&token=b9e397cc-21da-4a4d-895a-f8a5c76842b3";

/// ! Button Text Size and Google Fonts .
Widget buttonTextSizeAndFont({required String text}) {
  return Text(text,
      style: GoogleFonts.asar(
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)));
}

// !  Product Name Text .
Widget productNameText({required String name, double? fontSize}) {
  return AutoSizeText(
    name,
    style: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
      fontSize: fontSize ?? 25,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    )),
    overflow: TextOverflow.ellipsis,
  );
}

// ! Product Price Text .
Widget productPriceText({required String price, double? fontSize}) {
  return AutoSizeText(price,
      style: GoogleFonts.aBeeZee(
          textStyle: TextStyle(
        fontSize: fontSize ?? 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      )),
      overflow: TextOverflow.ellipsis);
}

// !   Using Details Page Description Text
const String descriptionText =
    "Taste, among a surprising amount of other senses, also actually prepares the body to metabolise food. When we smell, taste, see, touch and even hear food, millions of signals shoot from the brain to our stomachs signalling that food is about to be consumed.";
