// @dart=2.9

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safebrowse/Screens/Auth/signup.dart';
import 'package:safebrowse/Screens/home.dart';
import 'package:safebrowse/Screens/resetScreen.dart';

class SignIn extends StatefulWidget {
  // const Login({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signUp() async {
    try {
      final UserCredential newUser = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (newUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Align(
                  alignment: Alignment.center,
                  child: Image(
                    height: 150,
                    image: AssetImage(
                      'assets/logo.png',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  TextFormField(
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)
                            ? null
                            : "Please Enter Correct Email";
                      },
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email')),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (val) {
                      return val.length > 6
                          ? null
                          : "Enter Password 6+ characters";
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      fillColor: Color(0xFF00A6A6),
                      focusColor: Color(0xFF00A6A6),
                    ),
                    obscureText: true,
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      minimumSize: Size(double.infinity, 30),
                      primary: Color(0xFF00A6A6)),
                  child: Text('Login', style: TextStyle(fontSize: 18))),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text(
                  'Don’t have an account? Sign Up',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ResetScreen()));
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
