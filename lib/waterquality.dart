import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_picker/analyzecameraimgs.dart';
import 'package:photo_picker/citizenscience.dart';
import 'package:photo_picker/turbidity.dart';

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
      home: WaterQuality()
    );
  }
}

class WaterQuality extends StatefulWidget {
  const WaterQuality({ Key? key }) : super(key: key);

  @override
  State<WaterQuality> createState() => _HomeState();
}

class _HomeState extends State<WaterQuality> {

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
          children: [const Text("Water Quality",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),
            const SizedBox(height: 12),
            const Text("Water Quality is the assessment of a water sample's attributes against specific criteria. Assessing water quality involves various tests, including assessments of color, smell, temperature, acidity, presence of bacteria, biodiversity, and more. These approaches typically involves obtaining measurements of various water quality parameters which can be broadly categorized into physical, chemical, biological, and radioactive measurements. ",
            style: TextStyle(fontSize: 14,),textAlign: TextAlign.justify),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => CitizenScience()),);
                },
              child: Text('Back'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => Turbidity()),);
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
}