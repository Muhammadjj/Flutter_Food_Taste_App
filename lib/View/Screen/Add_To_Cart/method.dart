import 'package:flutter/material.dart';
import 'package:food_taste_app/Models/add_to_cart_model.dart';

import 'snackbar.dart';

class AppMethods {
  AppMethods._();
  static void addToCart(
      AddCartModelClass data, BuildContext context, List itemsOnBag) {
    bool contains = itemsOnBag.contains(data);

    if (contains == true) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(failedSnackBar());
    } else {
      itemsOnBag.add(data);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar());
    }
  }
}
