import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/View/Screen/NavigationBar_Home_Page/Popular_Page/popular_page_main.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:food_taste_app/Controller/Provider/change_navigation_bar_index_provider.dart';
import 'package:food_taste_app/View/Screen/NavigationBar_Home_Page/Home_Screen/home_page_main.dart';
import 'package:food_taste_app/View/Screen/NavigationBar_Home_Page/Profile_Page/profile_page_main.dart';

import 'Search_Page/search_page_main.dart';

class NavigationScreen extends ConsumerStatefulWidget {
  const NavigationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<NavigationScreen>
    with SingleTickerProviderStateMixin {
  List pages = const [
    // 1 HomePage Bottom Navigation Page .
    HomePage(),
    // 2 PopularPage Bottom Navigation Page .
    PopularScreen(),
    SearchBarPage(),
    // 2 ProfilePage Bottom Navigation Page .
    ProfilePage(),
  ];

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Todo: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("index");
    final navigationIndex = ref.watch(indexOfNavigation);
    return Scaffold(
        backgroundColor: allScreenColor,
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              backgroundColor: Colors.black,
              indicatorColor: textColor,
              labelTextStyle: const MaterialStatePropertyAll(
                  TextStyle(color: Colors.white))),
          child: NavigationBar(
              height: 60,
              elevation: 2,
              animationDuration: const Duration(seconds: 2),
              onDestinationSelected: (value) {
                ref.watch(indexOfNavigation.notifier).state = value;
              },
              selectedIndex: navigationIndex,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              destinations: const [
                // 1
                NavigationDestination(
                    icon: Icon(
                      CupertinoIcons.home,
                    ),
                    selectedIcon: Icon(
                      CupertinoIcons.house_fill,
                      color: iconColor,
                    ),
                    label: "Home Page"),
                // 2
                NavigationDestination(
                    icon: Icon(
                      Icons.amp_stories_rounded,
                    ),
                    label: "Popular",
                    selectedIcon: Icon(
                      Icons.amp_stories_rounded,
                      color: iconColor,
                    )),
                //  3
                NavigationDestination(
                    icon: Icon(
                      Icons.search,
                    ),
                    selectedIcon: Icon(
                      CupertinoIcons.search_circle,
                      color: iconColor,
                    ),
                    label: "Search"),
                NavigationDestination(
                    icon: Icon(
                      CupertinoIcons.person_alt_circle,
                    ),
                    selectedIcon: Icon(
                      Icons.person_pin,
                      color: iconColor,
                    ),
                    label: "Profile"),
              ]),
        ),
        body: pages[navigationIndex]);
  }
}
