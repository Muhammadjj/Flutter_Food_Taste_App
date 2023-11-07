import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

class ProfileImagePart extends StatelessWidget {
  const ProfileImagePart(
      {super.key, required this.backgroundImage, required this.text});
  final ImageProvider? backgroundImage;
  final String text;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    // var width = MediaQuery.sizeOf(context).width;
    return Stack(children: [
      Positioned(
        child: Container(
          height: 200,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(197, 248, 175, 175).withOpacity(0.9),
                  const Color.fromARGB(255, 255, 71, 76),
                  const Color.fromARGB(255, 207, 33, 39)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.1),
              child: AutoSizeText(
                text,
                style: GoogleFonts.aclonica(
                    textStyle: const TextStyle(
                        fontSize: 25,
                        shadows: [Shadow(color: Colors.white, blurRadius: 10)],
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 72,
              backgroundColor: const Color.fromARGB(255, 255, 71, 76),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: backgroundImage,
              ),
            )
          ],
        ),
      ),
    ]);
  }
}

class ProfileListTile extends StatelessWidget {
  const ProfileListTile(
      {super.key, required this.title, required this.leading, this.onTap});
  final Widget title;
  final Widget leading;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: width * 0.9,
      child: Neumorphic(
        style: NeumorphicStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            depth: 5,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            shadowLightColorEmboss: const Color.fromARGB(255, 230, 230, 230),
            shadowDarkColorEmboss: const Color.fromARGB(202, 51, 51, 51)),
        child: ListTile(
          onTap: onTap,
          title: title,
          leading: leading,
        ),
      ),
    );
  }
}
