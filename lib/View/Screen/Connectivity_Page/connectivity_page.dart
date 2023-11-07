import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:food_taste_app/View/Screen/Connectivity_Page/connectivity_widget.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/utility.dart';

class ConnectivityPage extends StatefulWidget {
  const ConnectivityPage({Key? key}) : super(key: key);
  @override
  State<ConnectivityPage> createState() => _MyAppState();
}

class _MyAppState extends State<ConnectivityPage> {
  Connectivity connectivity = Connectivity();

  String connectivityCheck(ConnectivityResult? result) {
    if (result == ConnectivityResult.wifi) {
      return "You are now connected to wifi";
    } else if (result == ConnectivityResult.mobile) {
      return "You are now connected to mobile data";
    } else if (result == ConnectivityResult.ethernet) {
      return "You are now connected to ethernet";
    } else if (result == ConnectivityResult.bluetooth) {
      return "You are now connected to bluetooth";
    } else {
      return "No Connection!!";
    }
  }

  getSignInMethod() {
    FirebaseAuth auth = FirebaseAuth.instance;
    // ** Check this Current user Login and Not a Login .
    var currentUser = auth.currentUser;
    if (currentUser != null) {
      Navigator.pushReplacementNamed(context, RoutesClassName.navigationScreen);
    } else {
      Navigator.pushReplacementNamed(context, RoutesClassName.loginPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<ConnectivityResult>(
          stream: connectivity.onConnectivityChanged,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ConnectivityData(
                onPressed: () {},
              );
            } else if (snapshot.hasData) {
              return ConnectivityData(onPressed: () {
                if (snapshot.data != ConnectivityResult.none) {
                  getSignInMethod();
                  showMessageToast(
                      "Connection Update ${snapshot.connectionState.name.toString()}");
                } else {
                  showCommonSnackBar(
                    context,
                    text: "No Connection",
                  );
                }
              });
            } else {
              return const Text("data");
            }
          }),
    );
  }
}
