import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/utility.dart';

class BackgroundAuthImage extends StatefulWidget {
  const BackgroundAuthImage({super.key});

  @override
  State<BackgroundAuthImage> createState() => _BackgroundAuthImageState();
}

class _BackgroundAuthImageState extends State<BackgroundAuthImage>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> offset;
  late AnimationController controller;

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
    offset = Tween(begin: const Offset(0.1, 0.0), end: const Offset(0.0, 0.06))
        .animate(controller);

    controller.forward();
  }

  @override
  void dispose() {
    // Todo: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return SlideTransition(
      position: offset,
      child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(backgroundImage1),
            fit: BoxFit.cover,
          )),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
            child: Container(
              color: allScreenColor.withOpacity(0.1),
            ),
          )),
    );
  }
}

/**
 * 
 */