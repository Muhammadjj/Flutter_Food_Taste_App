import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:food_taste_app/View/Screen/NavigationBar_Home_Page/Home_Screen/Side_Bar/side_bar_main.dart';
import 'package:food_taste_app/View/Screen/TabBar_Screens_Using_Home_Page/Burger/burger_main.dart';
import 'package:food_taste_app/View/Screen/TabBar_Screens_Using_Home_Page/Cake/cake_main.dart';
import 'package:food_taste_app/View/Screen/TabBar_Screens_Using_Home_Page/IceCream/ice_cream_main.dart';
import 'package:food_taste_app/View/Screen/TabBar_Screens_Using_Home_Page/Fried/fried_main.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:food_taste_app/View/Widgets/custom_size_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      animationDuration: const Duration(milliseconds: 200),
      child: Scaffold(
          backgroundColor: allScreenColor,
          drawer: const SideBarHalfPage(),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: allScreenColor,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesClassName.orderNowPage);
                },
                icon: const Icon(Icons.moped_sharp, color: iconColor),
              ),
              const CustomSizedBox(
                widthRatio: 0.01,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesClassName.favoritePage);
                },
                icon: const Icon(Icons.favorite, color: Colors.red),
              ),
              const CustomSizedBox(
                widthRatio: 0.01,
              ),
            ],
            bottom: AppBar(
              backgroundColor: allScreenColor,
              automaticallyImplyLeading: false,
              title: ListTile(
                title: ShimmerEffect(
                  baseColor: Colors.red,
                  highlightColor: Colors.white.withOpacity(0.8),
                  child: AutoSizeText(
                    "FOOD TASTE",
                    style: GoogleFonts.angkor(
                        textStyle: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                subtitle: AutoSizeText(
                  "Better Taste",
                  style: GoogleFonts.acme(
                      textStyle: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 20,
                    color: textColor,
                  )),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              // ! TabBar Set this Icon
              TabBar(
                  indicatorWeight: 3.0,
                  unselectedLabelColor: Colors.white,
                  isScrollable: true,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  labelColor: labelTabBarColor,
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                  labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            blurRadius: 2, color: Colors.white.withOpacity(0.7))
                      ],
                      overflow: TextOverflow.ellipsis),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: labelTabBarColor,
                  tabs: const [
                    Tab(
                      text: "Burger",
                    ),
                    Tab(
                      text: "Fried",
                    ),
                    Tab(
                      text: "IceCream",
                    ),
                    Tab(
                      text: "Cake",
                    ),
                  ]),
              // Define Pages Section .
              const Expanded(
                child: TabBarView(children: [
                  BurgerTabBar(),
                  FriedPage(),
                  UnknownPage(),
                  CakePage(),
                ]),
              )
            ],
          )),
    );
  }
}
