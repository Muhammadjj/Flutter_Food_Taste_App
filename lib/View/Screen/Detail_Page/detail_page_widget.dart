import 'package:flutter/cupertino.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:food_taste_app/View/Widgets/custom_size_box.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

class CartButtonAndImage extends StatelessWidget {
  const CartButtonAndImage({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        // * Floating Point Button Sections .
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NeumorphicFloatingActionButton(
              style: const NeumorphicStyle(
                color: Color.fromARGB(255, 255, 84, 85),
              ),
              mini: true,
              child: const Icon(
                CupertinoIcons.arrow_left,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            NeumorphicFloatingActionButton(
              style: const NeumorphicStyle(
                color: Color.fromARGB(255, 255, 84, 85),
              ),
              mini: true,
              child: const Icon(
                CupertinoIcons.shopping_cart,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, RoutesClassName.addToCartPage);
              },
            )
          ],
        ),
        const CustomSizedBox(
          heightRatio: 0.03,
        ),
        // * Image Sections .
        Container(
          height: height * 0.39,
          width: width * 0.95,
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
          child: child,
        ),
      ],
    );
  }
}
