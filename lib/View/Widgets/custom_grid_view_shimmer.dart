import 'package:flutter/material.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

class CustomGridViewShimmer extends StatelessWidget {
  const CustomGridViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return ShimmerEffect(
      enabled: true,
      baseColor: Colors.black.withOpacity(0.5),
      highlightColor: Colors.grey,
      child: Container(
          height: height * 0.1,
          width: width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(1, 0.0),
                  color: Colors.white,
                  blurRadius: 2.5,
                  blurStyle: BlurStyle.outer,
                  spreadRadius: 2),
            ],
            color: const Color.fromARGB(255, 56, 57, 66),
          )),
    );
  }
}
