import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/Provider/popular_page_firebase_data_provider.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:food_taste_app/Models/product_home_page_model_class.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/utility.dart';
import 'package:food_taste_app/View/Widgets/custom_size_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import '../../../Widgets/custom_grid_view.dart';
import '../../../Widgets/custom_grid_view_shimmer.dart';

class PopularScreen extends ConsumerStatefulWidget {
  const PopularScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PopularScreenState();
}

class _PopularScreenState extends ConsumerState<PopularScreen> {
  late PageController pageController;
  double pageOffset = 0.0;
  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    pageController = PageController(viewportFraction: 0.95);

    pageController.addListener(() {
      setState(() {
        pageOffset = (pageController.page!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final popularFirebaseData =
        ref.watch(PopularFirebaseGetData.getPopularData);
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: allScreenColor,
        resizeToAvoidBottomInset: false,
        body: popularFirebaseData.when(
          loading: () {
            return CustomGridView(
              // Using Custom GridView
              itemCount: popularFirebaseData.value?.length,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 300, crossAxisSpacing: 2),
              itemBuilder: (BuildContext context, int index) =>
                  const CustomGridViewShimmer(),
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(error.toString()),
            );
          },
          // Access FireStore
          data: (List<ProductHomePageModelClass> fetchData) {
            return Stack(
              children: [
                // ! Background Stack Image Layer Section.
                Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(backgroundImage),
                          fit: BoxFit.fill)),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        color: Colors.black.withOpacity(0.1),
                      )),
                ),
                PageView.builder(
                  itemCount: fetchData.length,
                  controller: pageController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (context, index) {
                    // Fetch data Popular Firestore Using ProductHomePageModelClass
                    // Model Class .
                    var popularName = fetchData[index].name.toString();
                    var popularImage = fetchData[index].imageUrl.toString();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ! Current Food/Product Name Section
                        AutoSizeText(
                          popularName,
                          maxLines: 1,
                          style: GoogleFonts.abrilFatface(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 35,
                                  color: Colors.white)),
                        ),
                        const CustomSizedBox(
                          heightRatio: 0.03,
                        ),
                        Neumorphic(
                          style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(40)),
                              depth: -10,
                              intensity: 2,
                              surfaceIntensity: 2,
                              shadowDarkColorEmboss:
                                  const Color.fromARGB(129, 0, 0, 0),
                              shadowLightColorEmboss:
                                  const Color.fromARGB(131, 255, 255, 255)),
                          child: InkWell(
                            onTap: () {
                              /// Current Page Popular Page and This page Send All data
                              /// firestore other Screen i means DetailCartPage .
                              Navigator.pushNamed(
                                  context, RoutesClassName.detailPage,
                                  arguments: ProductHomePageModelClass(
                                      imageUrl: popularImage,
                                      name: popularName,
                                      price: fetchData[index].price,
                                      popularPremiumStar: fetchData[index]
                                          .popularPremiumStar
                                          .toString()));
                            },
                            //! Stack Upper horizontally Scroll Layer Section.
                            child: Transform.scale(
                              scale: 1,
                              child: Container(
                                height: height * 0.6,
                                width: width * 0.85,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  // ! Hero Tag .
                                  child: Hero(
                                    tag: popularImage,
                                    child: Image(
                                      image: NetworkImage(
                                        popularImage,
                                      ),
                                      fit: BoxFit.cover,
                                      //! Parallax View in popular images .
                                      alignment: Alignment(
                                          -pageOffset.abs() + index, 0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            );
          },
        ));
  }
}
