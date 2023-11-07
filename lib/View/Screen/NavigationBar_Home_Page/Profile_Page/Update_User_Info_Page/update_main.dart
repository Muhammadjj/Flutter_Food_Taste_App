import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Models/user_info_model.dart';
import 'package:food_taste_app/View/Screen/NavigationBar_Home_Page/navigation_page_main.dart';
import 'package:form_validation/form_validation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Widgets/Components/Constant/background_image.dart';
import '../../../../Widgets/Components/Constant/colors.dart';
import '../../../../../Controller/Services/firebase_collections.dart';
import '../../../../Widgets/Components/Constant/utility.dart';
import '../../../../Widgets/decorated_text_field.dart';
import '../../../../Widgets/shining_button.dart';

class UpdateScreen extends ConsumerStatefulWidget {
  const UpdateScreen({super.key, required this.infoModel});

  // Current User Model Class .
  final UserInfoModel infoModel;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends ConsumerState<UpdateScreen> {
  //  Global Key .
  GlobalKey<FormState> key = GlobalKey<FormState>();

  /// ** TextEditingController .
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController idUpdate = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  // Current user data .
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    idUpdate.text = user!.uid;
    firstNameController.text = widget.infoModel.firstName.toString();
    lastNameController.text = widget.infoModel.lastName.toString();
    emailController.text = widget.infoModel.email.toString();
    phoneController.text = widget.infoModel.phone.toString();
  }

  Future<void> updateText() async {
    CollectionReference firestore = FirebaseAllCollection.firestoreUserData;
    var userDoc = firestore.doc(user!.uid);

    var updateUserInfo = UserInfoModel(
        userID: user!.uid,
        firstName: firstNameController.text.toString(),
        lastName: lastNameController.text.toString(),
        email: emailController.text.toString(),
        phone: phoneController.text.toString());

    userDoc.update(updateUserInfo.toMap());
  }

  @override
  void dispose() {
    // Todo: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    idUpdate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: allScreenColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // ! background Image Section
          const BackgroundAuthImage(),
          // ! SignUp Page Section .
          ListView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                // BACK ICON
                child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          CupertinoIcons.arrow_left,
                          color: iconColor,
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Update Text .
                      AutoSizeText(
                        "UPDATE",
                        style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                                fontSize: 35,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      //  TextForm Field Section .
                      SizedBox(
                        height: height * 0.1,
                      ),

                      BlurTextField(
                        height: height * 0.095,
                        width: width * 0.95,
                        prefixIcon: const Icon(
                          CupertinoIcons.person_alt_circle,
                          color: Colors.white,
                        ),
                        controller: firstNameController,
                        hintText: "First Name",
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Your First Name.";
                          }
                          final validator = Validator(
                            validators: [
                              const MaxLengthValidator(length: 1000)
                            ],
                          );
                          return validator.validate(
                            label: 'Required',
                            value: value,
                          );
                        },
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      // Last Name
                      BlurTextField(
                        height: height * 0.095,
                        width: width * 0.95,
                        controller: lastNameController,
                        hintText: "Last Name",
                        prefixIcon: const Icon(
                          CupertinoIcons.person_alt_circle,
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Your Last Name.";
                          }
                          final validator = Validator(
                            validators: [const MaxLengthValidator(length: 100)],
                          );
                          return validator.validate(
                            label: 'Required',
                            value: value,
                          );
                        },
                      ),

                      //  Email
                      SizedBox(
                        height: height * 0.03,
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
                      SizedBox(
                        height: height * 0.03,
                      ),
                      // Phone
                      BlurTextField(
                        height: height * 0.095,
                        width: width * 0.95,
                        controller: phoneController,
                        hintText: "Phone",
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(
                          CupertinoIcons.phone_circle_fill,
                          color: Colors.white,
                        ),
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter Your Phone No.";
                          }
                          final validator = Validator(
                            validators: [
                              const PhoneNumberValidator(),
                              const MaxLengthValidator(length: 13)
                            ],
                          );
                          return validator.validate(
                            label: 'Required',
                            value: value,
                          );
                        },
                      ),
                      SizedBox(
                        height: height * 0.06,
                      ),
                      // Button
                      FoodTasteShineButton(
                        color: const Color.fromARGB(255, 255, 71, 76),
                        height: height * 0.08,
                        width: width * 0.8,
                        firstLinearGradientColors:
                            const Color.fromARGB(255, 255, 64, 71),
                        secondLinearGradientColors:
                            const Color.fromARGB(143, 253, 86, 86)
                                .withOpacity(0.7),
                        child: buttonTextSizeAndFont(text: "Edit Text"),
                        onTap: () {
                          if (key.currentState!.validate()) {
                            debugPrint("Update");

                            updateText().then((value) {
                              firstNameController.clear();
                              lastNameController.clear();
                              emailController.clear();
                              phoneController.clear();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const NavigationScreen(),
                                  ),
                                  (route) => false);
                            });
                          }
                        },
                      ),
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
}
