import 'package:firebaseoperations/view/firebaseimageupload.dart';
import 'package:flutter/material.dart';

import 'firebaseoperation.dart';

class Images extends StatefulWidget {
  const Images({super.key});

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Storage"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Home(),
                  ));
                },
                child: Text("Storage"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ImageUpload(),
                  ));
                },
                child: Text("Image Upload"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 246, 182, 7)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
