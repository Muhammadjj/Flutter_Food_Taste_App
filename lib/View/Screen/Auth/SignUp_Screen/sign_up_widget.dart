import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpGalleryImage extends StatelessWidget {
  const SignUpGalleryImage({super.key, required this.image, this.onTap});
  final Image? image;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        height: 130,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.amber,
        ),
        child: ClipRRect(borderRadius: BorderRadius.circular(30), child: image),
      ),
      Positioned(
          top: 100,
          left: 100,
          child: InkWell(
            onTap: onTap,
            child: const Icon(
              size: 30,
              CupertinoIcons.camera,
              color: Colors.white,
            ),
          ))
    ]);
  }
}
