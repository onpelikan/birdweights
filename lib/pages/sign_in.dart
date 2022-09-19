import 'package:birds_weights/services/auth.dart';
import 'package:birds_weights/shared/constants.dart';
import 'package:birds_weights/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({required this.toggleView, Key? key}) : super(key: key);

  final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: mainColor,
              elevation: 0.0,
              title: Text('Přihlášení pro vážení ptáků'),
              // actions: [
              //   TextButton.icon(
              //     icon: Icon(Icons.person),
              //     label: Text('Register'),
              //     onPressed: () {
              //       widget.toggleView();
              //     },
              //   ),
              // ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Column(
                children: [
                  SignInButton(
                    Buttons.Google,
                    onPressed: () async {
                      //setState(() => loading = true);
                      dynamic result = await _auth.signInGoogle();
                      if (result == null) {
                        if (mounted) {
                          setState(() {
                            error = 'Chyba při prihlášení.';
                            loading = false;
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
