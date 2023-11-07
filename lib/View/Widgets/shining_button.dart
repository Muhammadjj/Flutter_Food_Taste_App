import 'package:neumorphic_ui/neumorphic_ui.dart';

class FoodTasteShineButton extends StatefulWidget {
  const FoodTasteShineButton(
      {super.key,
      required this.child,
      required this.color,
      required this.onTap,
      required this.height,
      required this.width,
      this.loading = true,
      required this.firstLinearGradientColors,
      required this.secondLinearGradientColors});
  final Widget child;
  final Color color;
  final GestureTapCallback onTap;
  final double height;
  final double width;
  final bool loading;
  final Color firstLinearGradientColors;
  final Color secondLinearGradientColors;
  @override
  State<FoodTasteShineButton> createState() => _ShineButtonState();
}

class _ShineButtonState extends State<FoodTasteShineButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    // Todo: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Neumorphic(
            style: NeumorphicStyle(
                depth: -10,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                shadowLightColorEmboss:
                    const Color.fromARGB(226, 224, 224, 224),
                shadowDarkColorEmboss: const Color.fromARGB(255, 22, 22, 22)),
            child: InkWell(
              onTap: widget.onTap,
              child: Container(
                  height: widget.height,
                  width: widget.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        widget.firstLinearGradientColors,
                        widget.secondLinearGradientColors,
                        widget.color,
                      ], stops: [
                        0.0,
                        controller.value,
                        1.0
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  child: widget.loading
                      ? Center(child: widget.child)
                      : const Center(
                          child: CircularProgressIndicator(),
                        )),
            ),
          );
        });
  }
}
