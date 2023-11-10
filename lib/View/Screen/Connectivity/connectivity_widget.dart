import 'package:flutter/cupertino.dart';

import '../../Widgets/Components/Constant/colors.dart';
import '../../Widgets/Components/Constant/utility.dart';

class ConnectivityData extends StatelessWidget {
  const ConnectivityData({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 400,
            width: double.infinity,
            child: Image(
              image: AssetImage(connectivity),
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CupertinoButton(
              color: textColor,
              onPressed: onPressed,
              child: const Text("Check Connectivity"))
        ],
      ),
    );
  }
}
