import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_taste_app/Models/product_home_page_model_class.dart';
import 'package:food_taste_app/Models/user_info_model.dart';
import 'package:food_taste_app/View/Screen/Add_To_Cart/add_to_cart_main.dart';
import 'package:food_taste_app/View/Screen/Auth/Login_Screen/login_screen_main.dart';
import 'package:food_taste_app/View/Screen/Auth/SignUp_Screen/sign_up_main.dart';
import 'package:food_taste_app/View/Screen/Auth/Splash_Screen/splash_screen_main.dart';
import 'package:food_taste_app/View/Screen/Check_Out_Page/check_out_page.dart';
import 'package:food_taste_app/View/Screen/Detail_Page/detail_page_main.dart';
import 'package:food_taste_app/View/Screen/Favorite/favorite_main.dart';
import 'package:food_taste_app/View/Screen/NavigationBar_Home_Page/Profile_Page/Update_User_Info_Page/update_main.dart';
import 'package:food_taste_app/View/Screen/NavigationBar_Home_Page/navigation_page_main.dart';
import 'package:food_taste_app/View/Screen/Order_Now_Final_Page/order_now_page.dart';
import '../../View/Screen/Connectivity/connectivity_page.dart';

// ! Routes Naming Class
class RoutesClassName {
  static const String splashScreen = "SplashScreen";
  static const String loginPage = "LoginPage";
  static const String signUpPage = "SignUpPage";
  static const String navigationScreen = "NavigationScreen";
  static const String updateUserInfoScreen = "UpdateScreen";
  static const String detailPage = "DetailPage";
  static const String addToCartPage = "AddToCartPage";
  static const String connectivityPage = "ConnectivityPage";
  static const String checkOutPage = "CheckOutPage";
  static const String orderNowPage = "OrderNowPage";
  static const String favoritePage = "FavoritePage";
}

// ! ALL SCREEN HANDLE
class RoutesMethod {
  static Route<dynamic>? onGenerateMethod(RouteSettings settings) {
    // 1
    if (settings.name == RoutesClassName.signUpPage) {
      return PageRoutes(child: const SignUpScreen());
    }
    // 2
    else if (settings.name == RoutesClassName.loginPage) {
      return PageRoutes(child: const LoginScreen());
    }
    // 3
    else if (settings.name == RoutesClassName.navigationScreen) {
      return PageRoutes(child: const NavigationScreen());
    }
    //  4
    else if (settings.name == RoutesClassName.updateUserInfoScreen) {
      return PageRoutes(
          child: UpdateScreen(infoModel: settings.arguments as UserInfoModel));
    }
    // 5
    else if (settings.name == RoutesClassName.detailPage) {
      return PageRoutes(
          child: DetailPage(settings.arguments as ProductHomePageModelClass));
    }
    // 6
    else if (settings.name == RoutesClassName.addToCartPage) {
      return PageRoutes(child: const AddToCartScreen());
    }
    // 7
    else if (settings.name == RoutesClassName.connectivityPage) {
      return PageRoutes(child: const ConnectivityPage());
    }
    // 8
    else if (settings.name == RoutesClassName.checkOutPage) {
      return PageRoutes(child: const CheckOutScreen());
    }
    // 9
    else if (settings.name == RoutesClassName.orderNowPage) {
      return PageRoutes(child: const OrderNowPage());
    }
    // 10
    else if (settings.name == RoutesClassName.splashScreen) {
      return PageRoutes(child: const SplashScreen());
    }
    // 11
    else if (settings.name == RoutesClassName.favoritePage) {
      return PageRoutes(child: const FavoritePage());
    }
    // Not Found Page .
    else {
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.red.shade400,
          body: const Center(
            child: AutoSizeText("DO'NT FETCH THIS PAGE",
                style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    }
  }
}

// ! Screens Page Transitions .
class PageRoutes extends PageRouteBuilder {
  final Widget child;
  PageRoutes({required this.child})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(
                parent: animation, curve: Curves.fastEaseInToSlowEaseOut);
            return ScaleTransition(
              scale: animation,
              alignment: Alignment.center,
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return child;
          },
        );
}
