import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_picker/analyzecameraimgs.dart';
import 'package:photo_picker/spm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;

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
      home: const OtherParams()
    );
  }
}

class OtherParams extends StatefulWidget {
  const OtherParams({ Key? key }) : super(key: key);

  @override
  State<OtherParams> createState() => _HomeState();
}

class _HomeState extends State<OtherParams> {
final _formKey = GlobalKey<FormState>();

  Future<void> uploaddata() async
  {
    CollectionReference users = FirebaseFirestore.instance.collection('scientists');
      users.add({
        'name':globals.nameController.text,
        'password':globals.passwordController.text,
        'email':globals.emailController.text,
        'chlorophyll-a': globals.chlorophylla.text,
        'temperature': globals.temperature.text,
        'pH': globals.pH.text,
        'transparancy': globals.transparency.text,
        'cloudy':globals.isCloudy,
        'comments':globals.comments.text,
        
      }); 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('AquaLens'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("   Is the weather cloudy?          ", style: TextStyle(fontFamily: 'RobotoMono', fontSize: 15),),
                Switch(
                  value: globals.isCloudy,
                  onChanged: (value) {
                    setState(() {
                      globals.isCloudy = value;
                    });
                  },
                ),
                Text(
                  globals.isCloudy ? 'Yes' : 'No',style: TextStyle(fontFamily: 'RobotoMono',fontSize: 15,),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Chlorophyll-a  ", style: TextStyle(fontFamily: 'RobotoMono', fontSize: 15),),
                Container(
                  width: 150,
                  height: 50,
                  padding: EdgeInsets.all(9.0),
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0,),),
                    controller: globals.chlorophylla,
                  ),
                ),
                Text("g/L  ", style: TextStyle(fontFamily: 'RobotoMono', fontSize: 15),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Temperature ", style: TextStyle(fontFamily: 'RobotoMono', fontSize: 15),),
                Container(
                  width: 150,
                  height: 50,
                  padding: EdgeInsets.all(9.0),
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0,),),
                    controller: globals.temperature,
                  ),
                ),
                Text(" \u00B0C", style: TextStyle(fontFamily: 'RobotoMono', fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("    pH         ", style: TextStyle(fontFamily: 'RobotoMono', fontSize: 15),),
                Container(
                  width: 150,
                  height: 50,
                  padding: EdgeInsets.all(9.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                    ),
                    controller: globals.pH,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Transparency  ", style: TextStyle(fontFamily: 'RobotoMono', fontSize: 15),),
                Container(
                  width: 150,
                  height: 50,
                  padding: EdgeInsets.all(9.0),
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0,),),
                    controller: globals.transparency,
                  ),
                ),
                Text(" cm ", style: TextStyle(fontFamily: 'RobotoMono', fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, // Aligns vertically
                children: [
                  Text("Comments  ", style: TextStyle(fontFamily: 'RobotoMono', fontSize: 15), textAlign: TextAlign.left,),
                  Container(
                    width: 150,
                    height: 100,
                    padding: EdgeInsets.all(4.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0), // Adjust vertical padding for centering
                      ),
                      controller: globals.comments,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SPM()),);
                  },
                  child: Text('Back'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AnalyzeImages()),);
                  },
                  child: Text('Next'),
                ),
                ElevatedButton(
                onPressed: uploaddata,
                child: const Text('Upload'),
        ),
              ],
            ),
          ],
        ),
      )
    );
  }
}