import 'dart:ui';

import 'package:flutter/material.dart';

// class TextFieldFoodTaste extends StatelessWidget {
//   const TextFieldFoodTaste(
//       {super.key,
//       required this.hintText,
//       this.prefixIcon,
//       this.suffixIcon,
//       this.keyboardType,
//       this.obscureText = false,
//       this.obscuringCharacter = "*",
//       this.validator,
//       this.textInputAction,
//       required this.controller});
//   final String hintText;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final TextInputType? keyboardType;
//   final bool obscureText;
//   final String obscuringCharacter;
//   final FormFieldValidator? validator;
//   final TextInputAction? textInputAction;
//   final TextEditingController controller;
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       validator: validator,
//       enableSuggestions: true,
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.black),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(
//               color: Color.fromARGB(255, 202, 153, 55), width: 1.5),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.red),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(
//               color: Color.fromARGB(255, 255, 64, 71), width: 1.5),
//         ),
//         errorStyle:
//             const TextStyle(color: Colors.red, overflow: TextOverflow.ellipsis),
//         hintText: hintText,
//         hintStyle: const TextStyle(
//             fontSize: 20, color: Colors.white, overflow: TextOverflow.ellipsis),
//         prefixIcon: prefixIcon,
//         suffixIcon: suffixIcon,
//       ),
//       keyboardType: keyboardType,
//       cursorColor: const Color.fromARGB(255, 202, 153, 55),
//       obscureText: obscureText,
//       autocorrect: true,
//       textInputAction: textInputAction,
//       obscuringCharacter: obscuringCharacter,
//     );
//   }
// }

// ** Blur TextField Using BackDropFilters .
class BlurTextField extends StatelessWidget {
  const BlurTextField(
      {super.key,
      this.height,
      this.width = 300,
      this.prefixIcon,
      this.hintText,
      this.validator,
      this.suffixIcon,
      this.keyboardType,
      this.obscureText = false,
      this.obscuringCharacter = "*",
      this.textInputAction,
      required this.controller,
      this.onChanged,
      this.onFieldSubmitted,
      this.readOnly = false,
      this.style = const TextStyle(color: Colors.white)});

  final double? height;
  final double? width;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String obscuringCharacter;
  final FormFieldValidator? validator;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final bool readOnly;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            readOnly: readOnly,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 255, 64, 71), width: 1.5),
                ),
                errorStyle: const TextStyle(
                    color: Colors.red, overflow: TextOverflow.ellipsis),
                hintText: hintText,
                hintStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                filled: true,
                fillColor: Colors.white.withOpacity(0.2)),
            cursorHeight: 18,
            obscureText: obscureText,
            obscuringCharacter: obscuringCharacter,
            keyboardType: keyboardType,
            style: style,
            textInputAction: textInputAction,
            cursorColor: const Color.fromARGB(255, 255, 64, 71),
          ),
        ),
      ),
    );
  }
}
