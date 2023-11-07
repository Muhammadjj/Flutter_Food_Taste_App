import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:food_taste_app/Controller/Services/firebase_collections.dart';
import 'package:food_taste_app/Models/user_info_model.dart';
import 'package:food_taste_app/View/Screen/NavigationBar_Home_Page/Profile_Page/profile_page_widget.dart';
import 'package:food_taste_app/View/Widgets/shining_button.dart';

import '../../../Widgets/Components/Constant/utility.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserInfoModel userInfo = UserInfoModel();
  User? user;
  // Create a String Variable because of this variable store the current user image .
  String? userInfoImage;

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    fireStoreFetchUserData();
  }

  /// Fetch User Data in Sign In Page .
  Future<void> fireStoreFetchUserData() async {
    User? user;
    user = FirebaseAuth.instance.currentUser;
    await FirebaseAllCollection.firestoreUserData
        .doc(user!.uid)
        .get()
        .then((value) {
      userInfo = UserInfoModel.fromJson(value.data()!);
      setState(() {});
    });
  }

  /// SignIn Gallery Picker Receive Image and Fetch in this Page .
  Future<void> fetchUserInfoImageFireStore() async {
    user = auth.currentUser;
    await FirebaseAllCollection.firestoreUserInfoImage
        .doc(user!.uid)
        .get()
        .then((value) {
      userInfoImage = value.data()?["getDownloadURL"];
      debugPrint(
          "Fetch Images >>>>>>>>>>>>>>>   ${userInfo.userID.toString()}");
      debugPrint("Fetch Images >>>>>>>>>>>>>  ${user!.uid.toString()}");
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() async {
    // Todo: implement didChangeDependencies
    super.didChangeDependencies();
    await fetchUserInfoImageFireStore();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    String firstName = userInfo.firstName ?? "Jawad";
    String lastName = userInfo.lastName ?? "Jani";
    String email = userInfo.email ?? "jawad@gmail.com";
    String phone = userInfo.phone ?? "+916456435646";
    return Scaffold(
      backgroundColor: allScreenColor,
      body: Column(
        children: [
          // ! Image Section Part .
          ProfileImagePart(
            backgroundImage: userInfoImage != null
                ? NetworkImage(userInfoImage.toString())
                : const NetworkImage(back),
            text: "${firstName.toString()}\t$lastName",
          ),

          //! User Sign In all Fetch All Data .

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                ProfileListTile(
                    title: Text(
                      "${firstName.toString()}\t$lastName",
                      style: const TextStyle(color: Colors.black),
                    ),
                    leading: const Icon(Icons.person_pin)),
                SizedBox(
                  height: height * 0.02,
                ),
                ProfileListTile(
                    title: Text(email),
                    leading: const Icon(Icons.mark_email_read_sharp)),
                SizedBox(
                  height: height * 0.02,
                ),
                ProfileListTile(
                    title: Text(phone),
                    leading: const Icon(Icons.phone_android_rounded)),
                SizedBox(
                  height: height * 0.02,
                ),
                ProfileListTile(
                  title: const Text("LOGOUT"),
                  leading: const Icon(Icons.login_outlined),
                  onTap: () {
                    auth.signOut().then((value) {
                      Navigator.pushReplacementNamed(
                        context,
                        RoutesClassName.loginPage,
                      );
                    });
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                // ! Edit Button Section
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FoodTasteShineButton(
                    color: const Color.fromARGB(255, 255, 71, 76),
                    height: height * 0.07,
                    width: width * 0.5,
                    firstLinearGradientColors:
                        const Color.fromARGB(255, 255, 64, 71),
                    secondLinearGradientColors:
                        const Color.fromARGB(255, 253, 86, 86).withOpacity(0.7),
                    child: buttonTextSizeAndFont(text: "EDIT PROFILE"),
                    onTap: () {
                      debugPrint("Click EDIT BUTTON");
                      Navigator.pushNamed(
                          context, RoutesClassName.updateUserInfoScreen,
                          arguments: UserInfoModel(
                              firstName: firstName,
                              lastName: lastName,
                              email: email,
                              phone: phone));
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
