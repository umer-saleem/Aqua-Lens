import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:exif/exif.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:path/path.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAZF2w1o8KUvaZihjthZc5BW0uWYvvYlZw",
        authDomain: "flutterstorage1-46e3f.firebaseapp.com",
        projectId: "flutterstorage1-46e3f",
        storageBucket: "flutterstorage1-46e3f.appspot.com",
        messagingSenderId: "710281281",
        appId: "1:710281281:web:93a26ab125284ae8749ec0",
        ),);
  }
  else{
    WidgetsFlutterBinding.ensureInitialized();
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MytomePage(title: 'Flutter Firebase Storage Upload App'),
    );
  }
}

class MytomePage extends StatefulWidget {
  const MytomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MytomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MytomePage> {
  int _counter = 0;

  Future<String?> uploadResume(result) async 
  {

    final fileBytes = result.files.first.bytes;
    final fileName = result.files.first.name; 

    Reference storageReference = FirebaseStorage.instance.ref('resume/').child(fileName);
    UploadTask uploadTask = storageReference.putData(fileBytes);
    TaskSnapshot snapshot =  await uploadTask.whenComplete((){});
    if (snapshot.state == TaskState.success)
    {
      var thumbnailUrl = await storageReference.getDownloadURL();
      print('File Uploaded Successfully.Download URL. $thumbnailUrl');
      return thumbnailUrl;
    }
    else
    {
      print("File Upload Failed!!!!");
      return null;
    }
  }

  Future<String?> uploadMotivationLetter(result) async 
  {
    final fileBytes = result.files.first.bytes;
    final fileName = result.files.first.name;

    Reference storageReference = FirebaseStorage.instance.ref('motivationletter/').child(fileName);
    UploadTask uploadTask = storageReference.putData(fileBytes);
    TaskSnapshot snapshot =  await uploadTask.whenComplete((){});
    if (snapshot.state == TaskState.success)
    {
      var thumbnailUrl = await storageReference.getDownloadURL();
      print('File Uploaded Successfully.Download URL. $thumbnailUrl');
      
      return thumbnailUrl;
    }
    else
    {
      print("File Upload Failed!!!!");
      return null;
    }
  }

  Future<void> selectResume() async
  {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['pdf','jpg','jpeg','JPG'],);
    if (result!=null)
    {

      String? uploadedImageUrl = await uploadResume(result);
      if (uploadedImageUrl != null && uploadedImageUrl.isNotEmpty)
      {
          setState(() 
          {
            var imageUrl = uploadedImageUrl;
          });
      }
    }
  }

  Future<void> selectMotivationLetter() async
  {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['pdf'],);
    if (result!=null)
    {

      String? uploadedImageUrl = await uploadMotivationLetter(result);
      if (uploadedImageUrl != null && uploadedImageUrl.isNotEmpty)
      {
          setState(() 
          {
            var imageUrl = uploadedImageUrl;
          });

          
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
            onPressed: selectResume,
            child: const Text('Upload'),
          ),
          const Text("Curriculum Vitae",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: selectMotivationLetter,
            child: const Text('Upload'),
          ),
          const Text("Motivation Letter",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:null,
        tooltip: 'Increment',
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
