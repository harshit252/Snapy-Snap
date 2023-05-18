import 'package:college_project/Screens/HomeScreen.dart';
import 'package:college_project/Screens/splashScreen.dart';
import 'package:college_project/homepage.dart';
import 'package:flutter/material.dart';

import 'Screens/auth/loginScreen.dart';
/*import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';*/


late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp();*/
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/*_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}*/

/*class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const SignInScreen(
              providerConfigs: [EmailProviderConfiguration()],
            );
          }
        });
  }
}*/
