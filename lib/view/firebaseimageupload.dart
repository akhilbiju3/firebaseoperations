import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image upload"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageUrl.isNotEmpty
                  ? Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(imageUrl), fit: BoxFit.cover),
                        color: Colors.red,
                      ),
                    )
                  : Container(
                      height: 150,
                      width: 150,
                      color: Colors.red,
                      child: Center(child: Text("No Image")),
                    ),
              ElevatedButton(
                onPressed: () async {
                  XFile? _selectedImage =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (_selectedImage != null) {
                    final storageRef = FirebaseStorage.instance
                        .ref(); //accessing firebase storage
                    final imageRef =
                        storageRef.child("images"); // folder image created
                    final uploadRef = imageRef.child(DateTime.now()
                        .microsecondsSinceEpoch
                        .toString()); //different images will save as different datetimestamps
                    try {
                      await uploadRef.putFile(
                          File(_selectedImage.path)); //put file to storage
                      var downloadUrl = await uploadRef
                          .getDownloadURL(); //get the download url of the image
                      setState(() {
                        imageUrl = downloadUrl;
                        print(imageUrl);
                      });
                    } catch (e) {
                      print(e);
                    }
                  }
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
