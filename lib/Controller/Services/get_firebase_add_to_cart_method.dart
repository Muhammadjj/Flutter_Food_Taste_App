import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Models/add_to_cart_model.dart';

class AddToCartFetchDataMethod {
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
}
