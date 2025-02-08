import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_picker/waterquality.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),),
      debugShowCheckedModeBanner: false,
      home: CitizenScience()
    );
  }
}

class CitizenScience extends StatefulWidget {
  const CitizenScience({ Key? key }) : super(key: key);

  @override
  State<CitizenScience> createState() => _HomeState();
}

class _HomeState extends State<CitizenScience> {
   
   File ? _selectedImgae;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('AquaLens'),
      ),
      body: Center(
        child:Padding(padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text("Citizen Science",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),
          const SizedBox(height: 12),
          const Text("Citizen science is a form of scientific research conducted, in whole or in part, by amateur or nonprofessional scientists. It often involves the public in data collection, analysis, and reporting, contributing valuable information and insights to scientific projects. Through citizen science, individuals can engage in scientific endeavors, help advance knowledge, and contribute to meaningful discoveries.",
          style: TextStyle(fontSize: 14,),textAlign: TextAlign.justify),
          const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => WaterQuality()),);
                },
              child: Text('Next'),
            ),
            ],),
          ],
        ),
      ),
      )
    );
  }

  Future _pickImageFromGallery() async {
   final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
   
   if(returnedImage == null) return;
   setState(() {
     _selectedImgae = File(returnedImage.path);
   });
  }

  Future _pickImageFromCamera() async {
   final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
   
   if(returnedImage == null) return;
   setState(() {
     _selectedImgae = File(returnedImage.path);
   });
  }
}