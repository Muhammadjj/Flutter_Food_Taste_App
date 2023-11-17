import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'View/Widgets/Components/Constant/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyCZPuzIeRvK-p-8nlWMtT6YOuj-dBRQp9A",
              appId: "1:247339037069:android:cd4d7b7d6791b992218dc4",
              messagingSenderId: "247339037069",
              projectId: "food-taste-app-5a86f",
              storageBucket: "food-taste-app-5a86f.appspot.com"))
      : Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: statusBarColors,
      statusBarIconBrightness: Brightness.light));
  runApp(const FoodApp());
}

class FoodApp extends StatelessWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Food Taste',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white),
          canvasColor: Colors.black,
          primaryIconTheme: const IconThemeData(color: Colors.white),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 71, 76)),
          useMaterial3: true,
        ),
        initialRoute: RoutesClassName.splashScreen,
        onGenerateRoute: RoutesMethod.onGenerateMethod,
      ),
    );
  }
}
