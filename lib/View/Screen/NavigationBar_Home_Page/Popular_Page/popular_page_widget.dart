// import 'dart:ui';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:neumorphic_ui/neumorphic_ui.dart';

// // ! DO'NT USING THIS CODE
// class PopularProductDesignWidgets extends ConsumerStatefulWidget {
//   const PopularProductDesignWidgets({
//     super.key,
//     this.onTap,
//     required this.popularImage,
//     required this.pageItemCount,
//     required this.popularName,
//   });
//   final String popularImage;
//   final String popularName;
//   final int? pageItemCount;
//   final GestureTapCallback? onTap;
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _PopularWidgetsState();
// }

// class _PopularWidgetsState extends ConsumerState<PopularProductDesignWidgets> {
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.sizeOf(context).height;
//     var width = MediaQuery.sizeOf(context).width;
//     return Stack(
//       children: [
//         Container(
//           height: height,
//           width: width,
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage("asset/images/popularBurger.jpg"),
//                   fit: BoxFit.fill)),
//           child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//               child: Container(
//                 color: Colors.black.withOpacity(0.1),
//               )),
//         ),
//         PageView.builder(
//           itemCount: widget.pageItemCount,
//           scrollDirection: Axis.horizontal,
//           physics: const BouncingScrollPhysics(
//               parent: AlwaysScrollableScrollPhysics()),
//           itemBuilder: (context, index) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   AutoSizeText(
//                     widget.popularName,
//                     style: GoogleFonts.aBeeZee(
//                         textStyle:
//                             const TextStyle(fontSize: 30, color: textColor)),
//                   ),
//                   Neumorphic(
//                     style: NeumorphicStyle(
//                         boxShape: NeumorphicBoxShape.roundRect(
//                             BorderRadius.circular(40)),
//                         depth: -10,
//                         intensity: 2,
//                         surfaceIntensity: 2,
//                         shadowDarkColorEmboss:
//                             const Color.fromARGB(129, 0, 0, 0),
//                         shadowLightColorEmboss:
//                             const Color.fromARGB(131, 255, 255, 255)),
//                     child: InkWell(
//                       onTap: widget.onTap,
//                       child: Container(
//                         height: height * 0.6,
//                         width: width * 0.85,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(40),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(40),
//                           child: Image(
//                             image: NetworkImage(widget.popularImage),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         )
//       ],
//     );
//   }
// }
