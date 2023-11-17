import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:food_taste_app/Controller/Services/firebase_collections.dart';
import 'package:food_taste_app/Models/user_info_model.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/utility.dart';
import 'package:food_taste_app/View/Widgets/custom_size_box.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../../../../Widgets/Components/Constant/colors.dart';

class SideBarHalfPage extends ConsumerStatefulWidget {
  const SideBarHalfPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SideBarHalfPageState();
}

class _SideBarHalfPageState extends ConsumerState<SideBarHalfPage> {
  UserInfoModel userInfoModel = UserInfoModel();
  User? user = FirebaseAuth.instance.currentUser;
  String? userInfoImage;
  // ** Current User Info data .
  Future<void> getInfoFirebaseData() {
    return FirebaseAllCollection.firestoreUserData
        .doc(user!.uid)
        .get()
        .then((value) {
      userInfoModel = UserInfoModel.fromJson(value.data()!);
      setState(() {});
    });
  }

//  ** Current user IMAGE .
  Future<void> getCurrentUserFirebaseImage() {
    return FirebaseAllCollection.firestoreUserInfoImage
        .doc(user!.uid)
        .get()
        .then((value) {
      userInfoImage = value.data()!['getDownloadURL'];
    });
  }

  @override
  void didChangeDependencies() {
    // Todo: implement didChangeDependencies
    super.didChangeDependencies();
    getInfoFirebaseData();
    getCurrentUserFirebaseImage();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    var allScreen = height + width;
    var firstName = userInfoModel.firstName ?? "Jawad";
    var lastName = userInfoModel.lastName ?? "Jani";

    return Drawer(
      elevation: 12.0,
      shadowColor: const Color.fromARGB(181, 223, 223, 223),
      backgroundColor: allScreenColor,
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50), topRight: Radius.circular(50))),
      child: ListView(
        children: [
          DrawerHeader(
              child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: allScreen * 0.04,
                  backgroundImage: NetworkImage(userInfoImage ?? networkImages),
                ),
                ShimmerEffect(
                  baseColor: Colors.white,
                  highlightColor: const Color.fromARGB(255, 250, 168, 162),
                  child: productNameText(
                      name: "${firstName.toString()} ${lastName.toString()}",
                      fontSize: 25),
                ),
                const CustomSizedBox(heightRatio: 0.01),
              ],
            ),
          )),

          // * listTile Working .
          listTile(
            icon: CupertinoIcons.home,
            text: "Home Page",
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, RoutesClassName.navigationScreen);
            },
          ),
          listTile(
            icon: CupertinoIcons.shopping_cart,
            text: "Add To Cart",
            onTap: () =>
                Navigator.pushNamed(context, RoutesClassName.addToCartPage),
          ),
          listTile(
            icon: Icons.moped_sharp,
            text: "Order Now",
            onTap: () =>
                Navigator.pushNamed(context, RoutesClassName.orderNowPage),
          ),

          listTile(
            icon: Icons.favorite,
            text: "Favorite",
            onTap: () =>
                Navigator.pushNamed(context, RoutesClassName.favoritePage),
          ),
          listTile(
              icon: Icons.logout_outlined,
              text: "LogOut",
              onTap: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((value) {
                  Navigator.pushNamed(context, RoutesClassName.loginPage);
                  showMessageToast("LogOut");
                });
              })
        ],
      ),
    );
  }
}

Widget listTile({String? text, IconData? icon, GestureTapCallback? onTap}) {
  return Card(
    color: const Color.fromARGB(255, 136, 136, 136),
    elevation: 5,
    shadowColor: const Color.fromARGB(255, 206, 206, 206).withOpacity(0.2),
    margin: const EdgeInsets.all(10),
    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: InkWell(
      onTap: onTap,
      child: ListTile(
        title: ShimmerEffect(
          baseColor: Colors.white,
          highlightColor: const Color.fromARGB(255, 250, 168, 162),
          child: Text(
            text.toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        leading: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    ),
  );
}
