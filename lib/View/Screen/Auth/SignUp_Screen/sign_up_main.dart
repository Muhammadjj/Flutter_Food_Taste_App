import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_taste_app/Controller/Provider/change_password_icon_provider.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:food_taste_app/Controller/Services/firebase_collections.dart';
import 'package:food_taste_app/View/Screen/Auth/SignUp_Screen/sign_up_widget.dart';
// import 'package:food_taste_app/View/Widgets/Components/Constant/custom_text_editing_controllers.dart';
import 'package:form_validation/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Widgets/Components/Constant/background_image.dart';
import '../../../Widgets/Components/Constant/colors.dart';
import '../../../../Models/user_info_model.dart';
import '../../../Widgets/decorated_text_field.dart';
import '../../../Widgets/shining_button.dart';
import '../../../Widgets/Components/Constant/utility.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  //  Global Key .
  /// ** TextEditingController .
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  final globalKey = GlobalKey<FormState>();

  // Firebase
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  // Image Picker .
  File? image;
  final imagePicker = ImagePicker();
  String? getDownloadURL;
  // Check this text or otherVise progressBar .
  bool loading = true;

//  ** Gallery Picker Method Using
  Future<void> getImagePicker() async {
    var picker = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 85);
    setState(() {
      if (picker != null) {
        image = File(picker.path);
      } else {
        throw Exception("Please Try Again");
      }
    });
  }

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    // Todo: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
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
          // ! background Image Section
          const BackgroundAuthImage(),
          // ! SignUp Page Section .
          SafeArea(
            child: ListView(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image From Gallery .
                        image != null
                            ? SignUpGalleryImage(
                                image: Image.file(
                                  image!.absolute,
                                  fit: BoxFit.cover,
                                ),
                                onTap: () => getImagePicker(),
                              )
                            : SignUpGalleryImage(
                                image: Image.asset(
                                  backgroundImage,
                                  fit: BoxFit.cover,
                                ),
                                onTap: () => getImagePicker(),
                              ),
                        //  TextForm Field Section .
                        SizedBox(
                          height: height * 0.04,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // First Name
                            Expanded(
                                child: BlurTextField(
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
                            )),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            // Last Name
                            Expanded(
                                child: BlurTextField(
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
                                  validators: [
                                    const MaxLengthValidator(length: 100)
                                  ],
                                );
                                return validator.validate(
                                  label: 'Required',
                                  value: value,
                                );
                              },
                            )),
                          ],
                        ),

                        //  Email .
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
                        // Password
                        SizedBox(
                          height: height * 0.03,
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
                                : const Icon(
                                    CupertinoIcons.lock_fill,
                                    color: Colors.white,
                                  ),
                          ),
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter Your Password.";
                            }
                            final validator = Validator(
                              validators: [
                                const MaxLengthValidator(length: 10)
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
                          child: buttonTextSizeAndFont(text: "SIGN UP"),
                          onTap: () {
                            setState(() {
                              loading = false;
                            });
                            if (globalKey.currentState!.validate()) {
                              createEndUser(emailController.text,
                                  passwordController.text);
                            }
                          },
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const AutoSizeText("Already Have An Account",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 219, 219, 219),
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis)),
                            InkWell(
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, RoutesClassName.loginPage),
                              child: const AutoSizeText("Login",
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
            ),
          )
        ],
      ),
    );
  }

// ** CREATE A END USER AND EMAIL, PASSWORD AUTHENTICATION
  void createEndUser(email, password) {
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      showMessageToast("Successfully Sign In");

      // ** Store this Data FireStore method .
      storeUserDataFireStore();
      storeUserGalleryImageFirebaseStorage().then((value) {
        saveUserInfoImageFireStore();
      });
      // * Sign up and store this fireStore Data clear all text Field .

      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      passwordController.clear();
      phoneController.clear();

      setState(() {
        loading = true;
      });
    }).onError((error, stackTrace) {
      // Flutter Toast .
      showMessageToast(error.toString());
    });
  }

  ///* Using Model Class and user all textField data pass to model class
  ///* and model class help of store data FireStore and easily fetch this
  ///* all data .
  storeUserDataFireStore() async {
    User? user;
    user = auth.currentUser;
    UserInfoModel infoModel = UserInfoModel();
    infoModel.userID = user!.uid;
    infoModel.firstName = firstNameController.text;
    infoModel.lastName = lastNameController.text;
    infoModel.email = user.email;
    infoModel.phone = phoneController.text;
    await FirebaseAllCollection.firestoreUserData
        .doc(user.uid)
        .set(infoModel.toMap());
  }

  ///* Hm jo apne gallery sa images pick kr raha ha osy hm firebaseStorage ma Save krwa raha ha
  ///* aur hm log ays sa hmy ak getDownloadURL ml raha ha jsy hm ak variable ma store krwa ka
  ///* hm firebaseFireStore ma apni images save krwa raha ha .
  Future storeUserGalleryImageFirebaseStorage() async {
    var postImages = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref = storage.ref("UserInfoImage/.jpg$postImages");
    await ref.putFile(image!.absolute);
    getDownloadURL = await ref.getDownloadURL();
    debugPrint(
        "Store Image Firebase Storage >>>>>>>>>> ${getDownloadURL.toString()}");
  }

  // phly hm ny apne image ko FirebaseStorage ma store krwaya aur ays ka bd
  // hm na apne images ko get krwana ka laya FirebaseFirestore ma save krwa
  // raha ha . Aur ya get image hm apna Profile Page Pr View Kr Skty ha .
  Future saveUserInfoImageFireStore() async {
    User? user;
    user = auth.currentUser;
    FirebaseAllCollection.firestoreUserInfoImage
        .doc(user!.uid)
        .set({"getDownloadURL": getDownloadURL}).then((value) {
      debugPrint("Store this Image in Firebase FireStore");
    });
  }
}
