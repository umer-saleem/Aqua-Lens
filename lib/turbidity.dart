import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_picker/analyzecameraimgs.dart';
import 'package:photo_picker/main.dart';
import 'package:photo_picker/spm.dart';
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
      home: Turbidity()
    );
  }
}

class Turbidity extends StatefulWidget {
  const Turbidity({ Key? key }) : super(key: key);

  @override
  State<Turbidity> createState() => _HomeState();
}

class _HomeState extends State<Turbidity> {

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
          children: [const Text("Turbidity",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),
            const SizedBox(height: 12),
            const Text("Turbidity is a key water quality parameter that measures the cloudiness or haziness of water caused by the presence of suspended particles such as sediment, algae, and organic matter. High turbidity levels can indicate pollution, erosion, or algal blooms, potentially impacting aquatic ecosystems and human health. By analyzing turbidity, scientists and citizens can assess the clarity of water bodies, monitor changes over time, and identify sources of contamination.",
            style: TextStyle(fontSize: 14,),textAlign: TextAlign.justify),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => WaterQuality()),);
                },
              child: Text('Back'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => SPM()),);
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