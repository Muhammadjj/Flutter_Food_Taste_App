import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Models/order_now_page_model_class.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/utility.dart';
import 'package:food_taste_app/View/Widgets/custom_size_box.dart';
import 'package:food_taste_app/View/Widgets/shining_button.dart';
import 'package:form_validation/form_validation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../Widgets/Components/Constant/background_image.dart';
import '../../Widgets/decorated_text_field.dart';

class CheckOutScreen extends ConsumerStatefulWidget {
  const CheckOutScreen({
    super.key,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends ConsumerState<CheckOutScreen> {
  // Validation Global Key .
  final globalKey = GlobalKey<FormState>();
  //  TextEditingController using this Screen .
  late TextEditingController customerNameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController postCodeController;

  // Firebase Services Objects .
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String dataTime = DateTime.now().microsecondsSinceEpoch.toString();
  // ! Using Internet Fetch This Current Location .
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLatLong() {
    Future<Position> data = _determinePosition();
    data.then((value) {
      debugPrint("value $value");
      setState(() {
        value.latitude;
        value.longitude;
      });

      getAddress(value.latitude, value.longitude);
    }).catchError((error) {
      debugPrint("Error $error");
    });
  }

  /// ! For convert latitude longitude to address
  /// !Using (GeoCoding) Package .
  getAddress(
    lat,
    long,
  ) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    setState(() {
      addressController.text =
          "${placemarks[0].street!} ${placemarks[0].country!} ${placemarks[0].name} ${placemarks[0].locality}";
    });

    for (int i = 0; i < placemarks.length; i++) {
      debugPrint("INDEX $i ${placemarks[i]}");
    }
  }

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    customerNameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    postCodeController = TextEditingController();
  }

  @override
  void dispose() {
    // Todo: implement dispose
    super.dispose();
    customerNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    postCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: allScreenColor,
        body: SafeArea(
          child: Stack(alignment: Alignment.center, children: [
            // ! background Image Section
            const BackgroundAuthImage(),
            // ! Checkout  Page Section .
            ListView(
              padding: const EdgeInsets.all(8.0),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Form(
                  key: globalKey,
                  child: Column(
                    children: [
                      productNameText(name: "CHECK OUT", fontSize: 30),

                      // TextFormField  Name .
                      const CustomSizedBox(
                        heightRatio: 0.1,
                      ),

                      BlurTextField(
                        height: height * 0.095,
                        width: width * 0.95,
                        controller: customerNameController,
                        hintText: "Customer Name",
                        prefixIcon: const Icon(
                          CupertinoIcons.person_alt_circle,
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Your Customer Name.";
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
                      const CustomSizedBox(
                        heightRatio: 0.03,
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
                      const CustomSizedBox(
                        heightRatio: 0.03,
                      ),
                      BlurTextField(
                        height: height * 0.095,
                        width: width * 0.95,
                        style: const TextStyle(color: Colors.amber),
                        controller: addressController,
                        hintText: "Address",
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(
                          CupertinoIcons.location_solid,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          onPressed: getLatLong,
                          icon: const Icon(Icons.location_searching_outlined),
                          color: const Color.fromARGB(255, 255, 194, 12),
                        ),
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter Your >> Icon .";
                          }
                          final validator = Validator(
                            validators: [],
                          );
                          return validator.validate(
                            label: 'Required',
                            value: value,
                          );
                        },
                      ),

                      const CustomSizedBox(
                        heightRatio: 0.03,
                      ),
                      BlurTextField(
                        height: height * 0.095,
                        width: width * 0.95,
                        controller: postCodeController,
                        hintText: "Postal Code",
                        prefixIcon: const Icon(
                          Icons.portrait_sharp,
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Your Customer Postal.";
                          }
                          final validator = Validator(
                            validators: [const MaxLengthValidator(length: 6)],
                          );
                          return validator.validate(
                            label: 'Required',
                            value: value,
                          );
                        },
                      ),
                      const CustomSizedBox(
                        heightRatio: 0.09,
                      ),
                      FoodTasteShineButton(
                        color: const Color.fromARGB(255, 255, 71, 76),
                        height: height * 0.08,
                        width: width * 0.8,
                        firstLinearGradientColors:
                            const Color.fromARGB(255, 255, 64, 71),
                        secondLinearGradientColors:
                            const Color.fromARGB(143, 253, 86, 86)
                                .withOpacity(0.7),
                        child: buttonTextSizeAndFont(text: "ORDER NOW"),
                        onTap: () {
                          if (globalKey.currentState!.validate()) {
                            // ! Order Now Data .
                            OrderNowModelClass orderNowModelClass =
                                OrderNowModelClass();
                            orderNowModelClass.orderUid = user!.uid;
                            orderNowModelClass.orderTextFieldCustomerName =
                                customerNameController.text.toString();
                            orderNowModelClass.orderTextFieldPhoneNo =
                                phoneController.text.toString();
                            orderNowModelClass.orderTextFieldAddress =
                                addressController.text.toString();
                            orderNowModelClass.orderTextFieldPostCode =
                                postCodeController.text.toString();

                            // ! Insert firebaseFireStore Database data .
                            firestore
                                .collection("UserInfo")
                                .doc(user!.uid)
                                .collection("OrderNow")
                                .doc(dataTime + user!.uid)
                                .set(orderNowModelClass.toMap())
                                .then((value) {
                              showMessageToast("Successfully Order Now");
                              // * Press button insert data firestore and clear the TextField .
                              customerNameController.clear();
                              phoneController.clear();
                              addressController.clear();
                              postCodeController.clear();
                            });
                          }
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ]),
        ));
  }
}
