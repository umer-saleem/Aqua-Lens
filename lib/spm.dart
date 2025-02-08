import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_picker/analyzecameraimgs.dart';
import 'package:photo_picker/main.dart';
import 'package:photo_picker/otherparameters.dart';
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
      home: SPM()
    );
  }
}

class SPM extends StatefulWidget {
  const SPM({ Key? key }) : super(key: key);

  @override
  State<SPM> createState() => _HomeState();
}

class _HomeState extends State<SPM> {

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
          children: [const Text("Suspended Particulate Matter (SPM)",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),
            const SizedBox(height: 12),
            const Text("Suspended Particulate Matter (SPM) refers to tiny solid or liquid particles suspended in water, which can originate from various sources such as soil erosion, industrial discharges, urban runoff, and biological activity. These particulates can affect water quality by reducing light penetration, which inhibits photosynthesis in aquatic plants, and by carrying harmful contaminants such as heavy metals and pathogens. Monitoring SPM is crucial for assessing the ecological health of water bodies, as high levels can degrade habitats, harm aquatic life, and pose risks to human health.",
            style: TextStyle(fontSize: 14,),textAlign: TextAlign.justify),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => Turbidity()),);
                },
              child: Text('Back'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => OtherParams()),);
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