import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taste_app/Controller/Services/data_get_firebase_order_now_method.dart';
import 'package:food_taste_app/View/Widgets/Components/Constant/colors.dart';
import 'order_now_widget.dart';

class OrderNowPage extends ConsumerStatefulWidget {
  const OrderNowPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderNowPageState();
}

class _OrderNowPageState extends ConsumerState<OrderNowPage> {
  // ! Fetch OrderNow All Data Class Objects.
  OrderNowFetchDataMethod orderNowFetchDataMethod = OrderNowFetchDataMethod();

  Future<void> deleteOrderNowFirebase({required String itemDeleteUid}) {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore
        .collection("UserInfo")
        .doc(user!.uid)
        .collection("OrderNow")
        .doc(itemDeleteUid)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: allScreenColor,
      body: FutureBuilder(
        future: orderNowFetchDataMethod.getOrderNowData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // ! OderNowCustomAppBar .
                    OderNowCustomAppBar(
                        pageName: "ORDER NOW",
                        icon: CupertinoIcons.arrow_left,
                        itemCount: snapshot.data?.length ?? 0),
                    //! Access this Data .
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          //*  Store data Help of Variable .
                          var customerName = snapshot
                              .data![index].orderTextFieldCustomerName
                              .toString();
                          var phoneNo = snapshot
                              .data![index].orderTextFieldPhoneNo
                              .toString();
                          var userAddress = snapshot
                              .data![index].orderTextFieldAddress
                              .toString();
                          var postCode = snapshot
                              .data![index].orderTextFieldPostCode
                              .toString();
                          return CartShowItem(
                            orderCustomerName: customerName,
                            orderPhoneNo: phoneNo,
                            orderAddress: userAddress,
                            orderPostal: postCode,
                            deleteOrderNow: () {
                              deleteOrderNowFirebase(
                                  itemDeleteUid: snapshot.data![index].orderUid
                                      .toString());
                              setState(() {});
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("No Data "),
            );
          }
        },
      ),
    );
  }
}
