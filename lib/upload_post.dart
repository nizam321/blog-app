import 'dart:io';
import 'package:blog/custom/custom_button.dart';
import 'package:blog/custom/custom_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
  XFile? _image;
  String? imageUrl;
  getimage() async {
    ImagePicker _picker = ImagePicker();
    _image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  uploadImage() async {
    File imageFile = File(_image!.path);

    FirebaseStorage _storage = FirebaseStorage.instance;
    UploadTask _uploadTask =
        _storage.ref('image').child(_image!.name).putFile(imageFile);

    TaskSnapshot snapshot = await _uploadTask;
    imageUrl = await snapshot.ref.getDownloadURL();

    CollectionReference blogData =
        FirebaseFirestore.instance.collection('user_data');

    blogData.add({
      'title': _titleController.text,
      'details': _detailsController.text,
      'img': imageUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Upload Blogs'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 1,
              color: Colors.grey.withOpacity(0.7),
              child: IconButton(
                onPressed: () {
                  getimage();
                },
                icon: Icon(Icons.camera_alt),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void dialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         content: Container(
  //           height: 120,
  //           child: Column(
  //             children: [
  //               InkWell(
  //                 onTap: () {
  //                   getimage();
  //                 },
  //                 child: ListTile(
  //                   leading: Icon(Icons.camera),
  //                   title: Text('Camera'),
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () {},
  //                 child: ListTile(
  //                   leading: Icon(Icons.photo_library),
  //                   title: Text('Gallery'),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
