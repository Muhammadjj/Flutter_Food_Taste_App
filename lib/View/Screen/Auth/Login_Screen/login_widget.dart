import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_taste_app/Controller/Routes/routes_method.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginDividerButton extends StatelessWidget {
  const LoginDividerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color.fromARGB(255, 255, 255, 255),
      height: 1.0,
      thickness: 1,
      endIndent: 60,
      indent: 60,
    );
  }
}

// Todo : Google Auth In Flutter Help With Firebase
FirebaseAuth auth = FirebaseAuth.instance;
Future<UserCredential> signInWithGoogle(BuildContext context) async {
  // Trigger the authentication flow  means ka end user ko ak dialog view
  // ho ga js pr end user apne email select kr skta ha aur agr hmra user
  // apne current email select krta ha to hmy authentication check krne prte ha
  // aur agr hmra user (Google Dialog) ko bnd krta ha to (GoogleSignInAccount)
  // Object return ma (null) bhjta haa . jo Future<UserCredential> ko mlta ha
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request means ka GoogleSignIn hona ka
  // bd hmy ab Two thing ki zarort ha (AccessToken, IdToken) ya dono hmy
  // hmra email ma majod data tk rasiye daty ha
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  // Create a new credential means ka Firebase ka Credential (conditions) ko
  // check krta ha aur asy ya sb kuch krna ka laya (accessToken , IdToken) ki
  //  zarort hote ha .
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  debugPrint("Google User : $googleUser");
  debugPrint("Google User Email : ${googleUser!.email.toString()}");
  debugPrint("Google User DisPlayName : ${googleUser.displayName}");
  // Once signed in, return the UserCredential
  return await auth.signInWithCredential(credential).then((value) {
    debugPrint("Google Button Login");
    // Utils().toast("Google Login");

    /// AGr hmra current user GoogleSign Ka process complete kr lata ha to hm
    /// asy HomePage Pr Navigate kr raha ha aur navigationScreen .
    debugPrint("Successfully ");
    Navigator.pushReplacementNamed(context, RoutesClassName.navigationScreen);
    return auth.signInWithCredential(credential);
  });
}
