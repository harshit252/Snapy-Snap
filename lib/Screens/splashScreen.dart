import 'dart:async';
import 'package:college_project/Screens/auth/loginScreen.dart';
import 'package:college_project/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (FirebaseAuth.instance.currentUser != null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()/*AuthGate()*/,),);

      }else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()/*AuthGate()*/,),);

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/SplashScreen.jpeg'),
      ),
    );
  }
}
