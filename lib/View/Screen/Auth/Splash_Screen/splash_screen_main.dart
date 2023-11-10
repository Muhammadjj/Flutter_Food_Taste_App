import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:food_taste_app/View/Screen/Auth/Splash_Screen/splash_screen_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? timer;
  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    stayThisPage();
  }

  stayThisPage() {
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      Navigator.pushReplacementNamed(context, RoutesClassName.connectivityPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // ! BackGroundGradient Colors Section.
          const BackGroundGradient(),
          // ! Splash Upper Working .
          SizedBox(
            height: height,
            width: width,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeInDown(
                    duration: const Duration(seconds: 1),
                    child: ShimmerEffect(
                      baseColor: Colors.white,
                      highlightColor: Colors.red,
                      child: const AutoSizeText(
                        "Food Taste",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(seconds: 1),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      // height: height * 0.5,
                      width: width,
                      child: const Image(
                          image: AssetImage("asset/images/splash.png")),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
