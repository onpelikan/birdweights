import 'package:birds_weights/pages/register.dart';
import 'package:birds_weights/pages/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = false;
      //showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (showSignIn) {
    //   return Register(toggleView: toggleView);
    // } else {
    return SignIn(toggleView: toggleView);
    //}
  }
}
