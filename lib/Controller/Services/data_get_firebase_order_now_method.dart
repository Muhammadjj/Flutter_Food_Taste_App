import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Models/order_now_page_model_class.dart';

class OrderNowFetchDataMethod {
  // Firebase Services
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  OrderNowModelClass orderNowModelClass = OrderNowModelClass();
  // Empty List Using This View (OrderNowModelClass) all Data .
  List<OrderNowModelClass> orderNowList = [];

// ** GetData Details Screen and Show OrderNow Screen .
  Future<List<OrderNowModelClass>> getOrderNowData() async {
    List<OrderNowModelClass> newList = [];
    var getData = await firestore
        .collection("UserInfo")
        .doc(user!.uid)
        .collection("OrderNow")
        .get();

    for (var element in getData.docs) {
      orderNowModelClass = OrderNowModelClass.fromMap(element.data());
      newList.add(orderNowModelClass);
      debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>....  $newList");
    }
    orderNowList = newList;
    debugPrint("....................${orderNowList.length}");

    return orderNowList;
  }
}
