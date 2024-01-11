import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseoperations/view/firebaseoperation.dart';
import 'package:firebaseoperations/view/home.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBS7HUrS2r6InRiYJGd3eNkKy4ui3wGodg",
          appId: "1:349986295856:android:34aa91ae4e32f0b6c95df5",
          messagingSenderId: " ",
          projectId: "flutterfire-93f9e",
          storageBucket: "flutterfire-93f9e.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Images(),
    );
  }
}
