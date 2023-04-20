import 'package:birds_weights/services/auth.dart';
import 'package:birds_weights/shared/constants.dart';
import 'package:birds_weights/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Loading()
        : Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: mainColor,
              elevation: 0.0,
              title: const Text('Přihlášení pro vážení ptáků'),
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Column(
                children: [
                  // TextButton(
                  //   onPressed: () {
                  //     dynamic result = _auth.signInAnon();
                  //     if (result == null) {
                  //       if (mounted) {
                  //         setState(() {
                  //           error = 'Chyba při prihlášení.';
                  //           loading = false;
                  //         });
                  //       }
                  //     }
                  //   },
                  //   child: const Text("Přihlásit"),
                  // ),
                  //const SizedBox(height: 20.0),
                  // SignInButton(
                  //   Buttons.Google,
                  //   onPressed: () async {
                  //     setState(() => loading = true);
                  //     dynamic result = await _auth.signInWithEmailAndPassword();
                  //     if (result == null) {
                  //       if (mounted) {
                  //         setState(() {
                  //           error = 'Chyba při prihlášení.';
                  //           loading = false;
                  //         });
                  //       }
                  //     }
                  //   },
                  // ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 80),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Zadejte email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Zadejte email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Heslo',
                          ),
                        ),
                        const SizedBox(height: 48),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 16, 105,
                                0), // Change the background color of the button
                          ),
                          onPressed: _signIn,
                          child: const Text('Přihlásit'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20.0),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          );
  }

  void _signIn() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final User user = (await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        ))
            .user;
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
