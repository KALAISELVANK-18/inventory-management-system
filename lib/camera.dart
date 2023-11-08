import 'dart:convert';
import 'dart:ui';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'home.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';

final user = FirebaseAuth.instance.currentUser;



// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}


class TakePictureScreen extends StatefulWidget {

  String tar;
  List<CameraDescription>? cameras;
  TakePictureScreen({
    super.key,required this.cameras,required this.tar
  });

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> with TickerProviderStateMixin{
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late TabController tabController;
  TextEditingController email=new TextEditingController();
  TextEditingController pass=new TextEditingController();
  TextEditingController conpass=new TextEditingController();
  int currentTabIndex = 0;

  @override
  void initState(){



    super.initState();
    _controller = CameraController(widget.cameras![0], ResolutionPreset.max);
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

   initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras[0];

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {



    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }


  void onTabChange() {
    setState(() {
      currentTabIndex = tabController.index;

    });
  }




  Map<String,dynamic> responsee={};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 7, 19, 95),
          title: Center(child: const Text('Quality check'))),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: (_controller.value.isInitialized)?Container(

                    child: ClipRRect(

                        borderRadius: BorderRadius.circular(16.0),
                        child: CameraPreview(_controller))):CircularProgressIndicator(),
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("click it!"),

        // Provide an onPressed callback.
        onPressed: () async {
          //!email.text.isEmpty && !pass.text.isEmpty
          if(email.text.isEmpty && pass.text.isEmpty){


            try {


              // Attempt to take a picture and get the file `image`
              // where it was saved.
              final image = await _controller.takePicture();
              var request;
              if(widget.tar=="shell")
              request = http.MultipartRequest('POST', Uri.parse('http://192.168.232.64:8000/shell'))..files.add(await http.MultipartFile.fromPath('image', image.path));

              if(widget.tar=="bagasse")
                request = http.MultipartRequest('POST', Uri.parse('http://192.168.232.64:8000/bagasse'))..files.add(await http.MultipartFile.fromPath('image', image.path));

              if(widget.tar=="saw")
                request = http.MultipartRequest('POST', Uri.parse('http://192.168.232.64:8000/saw'))..files.add(await http.MultipartFile.fromPath('image', image.path));

              if(widget.tar=="husk")
                request = http.MultipartRequest('POST', Uri.parse('http://192.168.232.64:8000/husk'))..files.add(await http.MultipartFile.fromPath('image', image.path));

              print(request.contentLength);
              var response = await request.send();
              print(12345);
              if (response.statusCode == 200) {
                // Handle success

                Map<String,dynamic>? dataMap = (await response.stream
                    .transform(utf8.decoder)
                    .transform(json.decoder)
                    .first) as Map<String, dynamic>?;
                print(dataMap?["result"]);



                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('The quality of ${widget.tar} is ${dataMap?["result"]} grade'),

                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );


              } else {
                // Handle error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.greenAccent,
                    content: Text('Failed to capture picture.'),
                  ),
                );
              }
              // Ensure that the camera is initialized.


              if (!mounted) return;


            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
              print("error");
            }}

        },
        icon: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Future<void> _showMyDialog(String targ,String val) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}