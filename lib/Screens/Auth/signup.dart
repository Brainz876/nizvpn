import 'package:flutter/material.dart';
import 'package:safebrowse/Screens/Auth/signin.dart';
import 'package:safebrowse/Screens/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safebrowse/Screens/resetScreen.dart';

class SignUp extends StatefulWidget {
  // const SignUp({Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  void signUp() async {
    try {
      final UserCredential newUser = await _auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (newUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OnBoardingPage()));
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
                alignment: Alignment.center,
                child: Image(
                  height: 150,
                  image: AssetImage(
                    'assets/logo.png',
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email')),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  fillColor: Color(0xFF00A6A6),
                  focusColor: Color(0xFF00A6A6),
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Re-Enter Password',
                  fillColor: Color(0xFF00A6A6),
                  focusColor: Color(0xFF00A6A6),
                ),
                obscureText: true,
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
                  child: Text('Sign Up', style: TextStyle(fontSize: 18))),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Text(
                  'Already have an account? Sign In',
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
