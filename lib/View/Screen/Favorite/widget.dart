import 'package:flutter/cupertino.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.price});
  final String imageUrl;
  final String name;
  final num? price;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 200,
            width: 200,
            child: Image(
              image: NetworkImage(imageUrl),
              fit: BoxFit.fill,
            )),
        Text(name),
        Text(price.toString())
      ],
    );
  }
}
