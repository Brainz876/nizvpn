// @dart=2.9
// import 'package:flutter/material.dart';
// import 'ui/screens/mainScreen.dart';

// main() {
//   runApp(
//     MaterialApp(
//       home: Root(),
//     ),
//   );
// }

// class Root extends StatefulWidget {
//   @override
//   _RootState createState() => _RootState();
// }

// class _RootState extends State<Root> {
//   @override
//   Widget build(BuildContext context) {
//     return MainScreen();
//   }
// }
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:vpn_app/Components/BottomNavigationBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safebrowse/Screens/Auth/signin.dart';
import 'package:safebrowse/Screens/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<User> user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

   @override
  void dispose() {
    user.cancel();
    super.dispose();
  }


 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// check if user is signed (Open Chat page ) if user is not signed in (open welcome page)
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? 'SignIn' : 'Home',

      ///key value pair
      routes: {
        'Home': (context) => Home(),
        'SignIn': (context) => SignIn(),
       
      },
      home: Home(),
    );
  }
  
}
