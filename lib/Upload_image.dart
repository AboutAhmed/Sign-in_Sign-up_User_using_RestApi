import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class uploadimagescreen extends StatefulWidget {
  const uploadimagescreen({super.key});

  @override
  State<uploadimagescreen> createState() => _uploadimagescreenState();
}

class _uploadimagescreenState extends State<uploadimagescreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  Future getImage() async {
    final PickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 75);

    if (PickedFile != null) {
      image = File(PickedFile!.path);
      setState(() {});
    } else {
      print("Image Not Selected");
    }
  }

  Future<void> UploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = new http.MultipartRequest('Post', uri);
    request.fields['title'] = "Static title";
    var multipart = new http.MultipartFile('image', stream, length);
    request.files.add(multipart);
    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print('File uploaded');
    } else {
      setState(() {
        showSpinner = false;
      });
      print('Fail to Upload');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: const Text(
            'Sign-Up & Login',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white70,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                child: image == null
                    ? Center(
                  child: Text('Pick image'),
                )
                    : Center(
                  child: Image.file(
                    image!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: () {
                UploadImage();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueGrey,
                  ),
                  height: 50,

                  child: const Center(child: Text('upload', style: TextStyle(fontSize: 20,),)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
