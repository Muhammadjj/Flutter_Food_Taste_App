import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/background_image.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/utility.dart';
import 'package:food_taste_app/Controller/Provider/change_password_icon_provider.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:food_taste_app/View/Screen/Auth/Login_Screen/login_widget.dart';
import 'package:form_validation/form_validation.dart';
import 'package:google_fonts/google_fonts.dart';
// import '../../../Widgets/Components/Constant/custom_text_editing_controllers.dart';
import '../../../Widgets/custom_size_box.dart';
import '../../../Widgets/decorated_text_field.dart';
import '../../../Widgets/shining_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  //  Global Key .
  final globalKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // Firebase
  FirebaseAuth auth = FirebaseAuth.instance;
  // Check this text or otherVise progressBar .
  bool loading = true;

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Todo: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    // Password Icon Change With help Of RiverPod .
    final passwordIcon = ref.watch(checkPassword);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: allScreenColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // ! background Images .
          const BackgroundAuthImage(),

          // ! Text Field Section .
          ListView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: globalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AutoSizeText(
                        "Food Taste",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 50,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      //  TextForm Field Section .
                      // SizedBox(
                      //   height: height * 0.1,
                      // ),
                      const CustomSizedBox(
                        heightRatio: 0.07,
                      ),
                      BlurTextField(
                        height: height * 0.095,
                        width: width * 0.95,
                        hintText: "Email",
                        controller: emailController,
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: iconColor,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Email.";
                          }
                          final validator = Validator(
                            validators: [
                              const EmailValidator(),
                              const MaxLengthValidator(length: 30)
                            ],
                          );
                          return validator.validate(
                            label: 'Required',
                            value: value,
                          );
                        },
                      ),
                      // Password
                      const CustomSizedBox(
                        heightRatio: 0.03,
                      ),

                      BlurTextField(
                        height: height * 0.095,
                        width: width * 0.95,
                        controller: passwordController,
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passwordIcon,
                        obscuringCharacter: "*",
                        prefixIcon: const Icon(
                          Icons.password_outlined,
                          color: Colors.white,
                        ),
                        // password Icon Change with help of River Pod .
                        suffixIcon: InkWell(
                          onTap: () {
                            if (passwordIcon == false) {
                              ref
                                  .read(checkPassword.notifier)
                                  .update((state) => true);
                            } else {
                              ref
                                  .read(checkPassword.notifier)
                                  .update((state) => false);
                            }
                          },
                          child: passwordIcon
                              ? const Icon(
                                  CupertinoIcons.lock,
                                  color: Colors.white,
                                )
                              : const Icon(CupertinoIcons.lock_fill,
                                  color: Colors.white),
                        ),
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter Your Password.";
                          }
                          final validator = Validator(
                            validators: [const MaxLengthValidator(length: 10)],
                          );
                          return validator.validate(
                            label: 'Required',
                            value: value,
                          );
                        },
                      ),
                      const CustomSizedBox(
                        heightRatio: 0.05,
                      ),

                      // ** Login Button Section .
                      FoodTasteShineButton(
                        loading: loading,
                        color: const Color.fromARGB(255, 255, 71, 76),
                        height: height * 0.08,
                        width: width * 0.8,
                        firstLinearGradientColors:
                            const Color.fromARGB(255, 255, 64, 71),
                        secondLinearGradientColors:
                            const Color.fromARGB(143, 253, 86, 86)
                                .withOpacity(0.7),
                        child: buttonTextSizeAndFont(text: "LOGIN"),
                        onTap: () {
                          setState(() {
                            loading = false;
                          });
                          if (globalKey.currentState!.validate()) {
                            alreadyCreateUser(
                                emailController.text, passwordController.text);
                          }
                        },
                      ),
                      const CustomSizedBox(
                        heightRatio: 0.1,
                      ),

                      // ** Divider Google Button Part .
                      Divider(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        height: 1.0,
                        thickness: 1,
                        endIndent: width * 0.1,
                        indent: width * 0.1,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            loading = !loading;
                          });
                          //  Google Button Background Working .
                          signInWithGoogle(context).then((value) {
                            setState(() {
                              loading = loading;
                            });
                          });
                        },
                        child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 64, 71),
                            radius: 30,
                            child: loading
                                ? Text("G",
                                    style: GoogleFonts.novaOval(
                                        textStyle: const TextStyle(
                                            fontSize: 35,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis)))
                                : const CircularProgressIndicator()),
                      ),
                      const CustomSizedBox(
                        heightRatio: 0.03,
                      ),
                      // Divider Google Part
                      Divider(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        height: 1.0,
                        thickness: 1,
                        endIndent: width * 0.1,
                        indent: width * 0.1,
                      ),

                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const AutoSizeText("Create Account",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 219, 219, 219),
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis)),
                          InkWell(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, RoutesClassName.signUpPage),
                            child: const AutoSizeText("Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

// ** ALREADY CREATE A END USER AND EMAIL, PASSWORD AUTHENTICATION
  void alreadyCreateUser(email, password) {
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      showMessageToast("Successfully Login ");
      setState(() {
        loading = !loading;
      });
      Navigator.pushReplacementNamed(
        context,
        RoutesClassName.navigationScreen,
      );
    });
  }
}
