import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:exif/exif.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;
import 'package:path/path.dart';
import 'package:photo_picker/foreluleslider.dart';
import 'dart:ui' as ui;
import 'package:photo_picker/otherparameters.dart';
import 'globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kIsWeb) {
    await Firebase.initializeApp(
      name: 'mycuteapp',
      options: const FirebaseOptions(
        apiKey: "",
        authDomain: "",
        projectId: "",
        storageBucket: "",
        messagingSenderId: "",
        appId: "",
        measurementId: ""
        ),);
  }
  else{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      name: 'mycuteapp',
      options: const FirebaseOptions(
        apiKey: "",
      authDomain: "",
      projectId: "",
      storageBucket: "",
      messagingSenderId: "",
      appId: "",
      measurementId: ""
        ),);
  }
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
      home: const AnalyzeImages()
    );
  }
}

class AnalyzeImages extends StatefulWidget {
  const AnalyzeImages({ Key? key }) : super(key: key);

  @override
  State<AnalyzeImages> createState() => _HomeState();
}

class _HomeState extends State<AnalyzeImages> {
   
   File ? _CameraWaterImage;
   File ? _CameraCardImage;
   File ? _CameraSkyImage;
   final WaterSurfaceReflectanceFactor = 0.028;
   final GrayCardReflectance = 0.18;

   String _displayTurbidity = '';
   String results = '';
   String _displayspm = '';
   String _reflectanceRed = '';
   double Turbidity = 0;
   num spm = 0;
   double reflectanceRed = 0;
   String _currentDate = '';
   String _currentTime = '';
   Uint8List? fileBytes;
   Uint8List? fileBytes1;
   Uint8List? fileBytes2;
   final ValueNotifier<double> _progress = ValueNotifier<double>(0.0); // Progress notifier

   String _formatDate(DateTime dateTime) {
    return '${_twoDigits(dateTime.day)}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.year)}';
  }

  String _formatTime(DateTime dateTime) {
    return '${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}:${_twoDigits(dateTime.second)}';
  }

  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  Future<void> _analyzeimages() async {
    double isospeed = 1 / 50;
    int exposure = 200;

    if (globals.globalCameraWaterImage == null || globals.globalCameraCardImage == null || globals.globalCameraSkyImage == null) {
      print('Please select all images.');
      return;
    }

    // Reset progress
    _progress.value = 0.0;

    final bytesWaterImage = await globals.globalCameraWaterImage!.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(bytesWaterImage);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image image = frameInfo.image;

    final ByteData? byteData = await image.toByteData();
    if (byteData == null) {
      print('Failed to convert image to bytes');
      return;
    } else {
      print("Read Water Image Successfully");
    }

    // Update progress
    _progress.value += 0.1;

    final List<int> redChannel = [];
    final List<int> greenChannel = [];
    final List<int> blueChannel = [];

    for (int i = 0; i < byteData.lengthInBytes; i += 4) {
      redChannel.add(byteData.getUint8(i));
      greenChannel.add(byteData.getUint8(i + 1));
      blueChannel.add(byteData.getUint8(i + 2));
    }

    final List<int> sortedRed = List.from(redChannel)..sort();
    final List<int> sortedGreen = List.from(greenChannel)..sort();
    final List<int> sortedBlue = List.from(blueChannel)..sort();

    final int medianRed = sortedRed[sortedRed.length ~/ 2];
    final int medianGreen = sortedGreen[sortedGreen.length ~/ 2];
    final int medianBlue = sortedBlue[sortedBlue.length ~/ 2];

    var RelativeLightLevelRed = (medianRed) / (exposure * isospeed);
    var RelativeLightLevelGreen = (medianGreen) / (exposure * isospeed);
    var RelativeLightLevelBlue = (medianBlue) / (exposure * isospeed);

    RelativeLightLevelRed = (RelativeLightLevelRed < 0) ? 0 : RelativeLightLevelRed;
    RelativeLightLevelGreen = (RelativeLightLevelGreen < 0) ? 0 : RelativeLightLevelGreen;
    RelativeLightLevelBlue = (RelativeLightLevelBlue < 0) ? 0 : RelativeLightLevelBlue;

    // Update progress
    _progress.value += 0.2;

    final bytesCardImage = await globals.globalCameraCardImage!.readAsBytes();
    final ui.Codec codec1 = await ui.instantiateImageCodec(bytesCardImage);
    final ui.FrameInfo frameInfo1 = await codec1.getNextFrame();
    final ui.Image image1 = frameInfo1.image;

    final ByteData? byteData1 = await image1.toByteData();
    if (byteData1 == null) {
      print('Failed to convert card image to bytes');
      return;
    } else {
      print("Read Card Image Successfully");
    }

    final List<int> redChannel1 = [];
    final List<int> greenChannel1 = [];
    final List<int> blueChannel1 = [];

    for (int i = 0; i < byteData1.lengthInBytes; i += 4) {
      redChannel1.add(byteData1.getUint8(i));
      greenChannel1.add(byteData1.getUint8(i + 1));
      blueChannel1.add(byteData1.getUint8(i + 2));
    }

    final List<int> sortedRed1 = List.from(redChannel1)..sort();
    final List<int> sortedGreen1 = List.from(greenChannel1)..sort();
    final List<int> sortedBlue1 = List.from(blueChannel1)..sort();

    final int medianRed1 = sortedRed1[sortedRed1.length ~/ 2];
    final int medianGreen1 = sortedGreen1[sortedGreen1.length ~/ 2];
    final int medianBlue1 = sortedBlue1[sortedBlue1.length ~/ 2];

    var RelativeLightLevelRed1 = (medianRed1) / (exposure * isospeed);
    var RelativeLightLevelGreen1 = (medianGreen1) / (exposure * isospeed);
    var RelativeLightLevelBlue1 = (medianBlue1) / (exposure * isospeed);

    RelativeLightLevelRed1 = (RelativeLightLevelRed1 < 0) ? 0 : RelativeLightLevelRed1;
    RelativeLightLevelGreen1 = (RelativeLightLevelGreen1 < 0) ? 0 : RelativeLightLevelGreen1;
    RelativeLightLevelBlue1 = (RelativeLightLevelBlue1 < 0) ? 0 : RelativeLightLevelBlue1;

    // Update progress
    _progress.value += 0.2;

    final bytesSkyImage = await globals.globalCameraSkyImage!.readAsBytes();
    final ui.Codec codec2 = await ui.instantiateImageCodec(bytesSkyImage);
    final ui.FrameInfo frameInfo2 = await codec2.getNextFrame();
    final ui.Image image2 = frameInfo2.image;

    final ByteData? byteData2 = await image2.toByteData();
    if (byteData2 == null) {
      print('Failed to convert sky image to bytes');
      return;
    } else {
      print("Read Sky Image Successfully");
    }

    final List<int> redChannel2 = [];
    final List<int> greenChannel2 = [];
    final List<int> blueChannel2 = [];

    for (int i = 0; i < byteData2.lengthInBytes; i += 4) {
      redChannel2.add(byteData2.getUint8(i));
      greenChannel2.add(byteData2.getUint8(i + 1));
      blueChannel2.add(byteData2.getUint8(i + 2));
    }

    final List<int> sortedRed2 = List.from(redChannel2)..sort();
    final List<int> sortedGreen2 = List.from(greenChannel2)..sort();
    final List<int> sortedBlue2 = List.from(blueChannel2)..sort();

    final int medianRed2 = sortedRed2[sortedRed2.length ~/ 2];
    final int medianGreen2 = sortedGreen2[sortedGreen2.length ~/ 2];
    final int medianBlue2 = sortedBlue2[sortedBlue2.length ~/ 2];

    var RelativeLightLevelRed2 = (medianRed2) / (exposure * isospeed);
    var RelativeLightLevelGreen2 = (medianGreen2) / (exposure * isospeed);
    var RelativeLightLevelBlue2 = (medianBlue2) / (exposure * isospeed);

    RelativeLightLevelRed2 = (RelativeLightLevelRed2 < 0) ? 0 : RelativeLightLevelRed2;
    RelativeLightLevelGreen2 = (RelativeLightLevelGreen2 < 0) ? 0 : RelativeLightLevelGreen2;
    RelativeLightLevelBlue2 = (RelativeLightLevelBlue2 < 0) ? 0 : RelativeLightLevelBlue2;

    // Update progress
    _progress.value += 0.2;

    double WaterLeavingRadianceRed = RelativeLightLevelRed - (WaterSurfaceReflectanceFactor * RelativeLightLevelRed2);
    double DownwellingIrradianceRed = (math.pi / GrayCardReflectance) * RelativeLightLevelRed1;

    double WaterLeavingRadianceBlue = RelativeLightLevelBlue - (WaterSurfaceReflectanceFactor * RelativeLightLevelBlue2);
    double DownwellingIrradianceBlue = (math.pi / GrayCardReflectance) * RelativeLightLevelBlue1;

    double WaterLeavingRadianceGreen = RelativeLightLevelGreen - (WaterSurfaceReflectanceFactor * RelativeLightLevelGreen2);
    double DownwellingIrradianceGreen = (math.pi / GrayCardReflectance) * RelativeLightLevelGreen1;

    double RemoteSensingReflectance = WaterLeavingRadianceRed / DownwellingIrradianceRed;
    reflectanceRed = RemoteSensingReflectance;

    if (DownwellingIrradianceRed > 0)
    {
        // ratio cancels any scaling factor
        reflectanceRed = WaterLeavingRadianceRed / DownwellingIrradianceRed;

        reflectanceRed = double.parse(reflectanceRed.toStringAsFixed(4));
        reflectanceRed = (reflectanceRed < 0) ? 0 : reflectanceRed;
    }

    // Calculating Turbidity

    if (reflectanceRed >= 0.0344)
    {
        // Red reflectace approches asymptote for trubidity over 80 NTU or Rrs over 0.0344
        Turbidity = 80;
        spm = math.pow(10, (1.02 * math.log(Turbidity) / math.log(10) - 0.04));
        spm = double.parse((spm).toStringAsFixed(2));
    }
    else
    {
        // From Leeuw and Boss 2018
        Turbidity = (22.57 * reflectanceRed) / (0.044 - reflectanceRed);
        spm = math.pow(10, (1.02 * math.log(Turbidity) / math.log(10) - 0.04));
        Turbidity = double.parse((Turbidity).toStringAsFixed(2));
        spm = double.parse((spm).toStringAsFixed(2));
    }

    // Update progress
    _progress.value = 1.0;

    setState(() {
      _reflectanceRed = reflectanceRed.toString();
    });

    //Turbidity = 223.49 * RemoteSensingReflectance + 0.2498;
    setState(() {
      _displayTurbidity = Turbidity.toString();
    });

    //spm = (0.4893 * Turbidity + 0.0281);
    setState(() {
      _displayspm = spm.toString();
    });
    await _printTurbidity(Turbidity);
  }

  Future<String?> uploadImages(result) async 
  {

    // final fileBytes = result.files.first.bytes;
    // final fileName = result.files.first.name; 

    final fileName = result.toString().split('/').last;
    final fileBytes = await result.readAsBytes();

    Reference storageReference = FirebaseStorage.instance.ref('cameraanalysis/').child(fileName);
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
    //FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['pdf','jpg','jpeg','JPG'],);
    // final result = await ImagePicker().pickImage(source: ImageSource.gallery);

    final result_card = globals.globalCameraCardImage;
    final result_sky = globals.globalCameraSkyImage;
    final result_water = globals.globalCameraWaterImage;

    if (result_card!=null || result_water!=null || result_sky!=null)
    {
      print('File Selected');

      String? uploadedImageUrl_card = await uploadImages(result_card);
      String? uploadedImageUrl_sky = await uploadImages(result_sky);
      String? uploadedImageUrl_water = await uploadImages(result_water);

      if (uploadedImageUrl_card != null && uploadedImageUrl_card.isNotEmpty)
      {
          setState(() 
          {
            var imageUrl_card = uploadedImageUrl_card;
          });
      }
      if (uploadedImageUrl_sky != null && uploadedImageUrl_sky.isNotEmpty)
      {
          setState(() 
          {
            var imageUrl_sky = uploadedImageUrl_sky;
          });
      }
      if (uploadedImageUrl_water != null && uploadedImageUrl_water.isNotEmpty)
      {
          setState(() 
          {
            var imageUrl_water = uploadedImageUrl_water;
          });
      }
    }
    else
    {
      print('No File Selected');
    }
  }

  Future<void> _printTurbidity(Turbidity) async {
    final now = DateTime.now();
    setState(() 
    {
      results = 'Results';
      _currentDate = 'Date = ' + _formatDate(now);
      _currentTime = 'Time = ' + _formatTime(now);
      _displayTurbidity = 'Turbidity = $Turbidity NTU';
      _displayspm = 'SPM = $spm mg/L';
      _reflectanceRed = 'Reflectance (Red) = $reflectanceRed';
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
          children: [const Text("Water Quality Analysis",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),
               const SizedBox(height: 10,),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Container(
                        width: 100,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: globals.globalCameraWaterImage != null
                          ? Image.file(globals.globalCameraWaterImage!,fit: BoxFit.cover)
                          : Center(),
                      ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 11, 11, 101),
                        foregroundColor: Colors.white,
                      ),
                      //onPressed: selectWater,
                      onPressed: _pickWaterImageFromCamera,
                      child: Text("Waterbody"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 11, 11, 101),
                        foregroundColor: Colors.white,
                      ),
                      //onPressed: selectWater,
                      onPressed: _pickWaterImageFromGallery,
                      child: Text("Waterbody"),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Container(
                        width: 100,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: globals.globalCameraCardImage != null
                          ? Image.file(globals.globalCameraCardImage!,fit: BoxFit.cover)
                          : Center(),
                      ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 11, 11, 101),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _pickCardImageFromCamera,
                      child: Text("Gray Card"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 11, 11, 101),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _pickCardImageFromGallery,
                      child: Text("Gray Card"),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Container(
                        width: 100,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: globals.globalCameraSkyImage != null
                          ? Image.file(globals.globalCameraSkyImage!,fit: BoxFit.cover)
                          : Center(),
                      ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 11, 11, 101),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _pickSkyImageFromCamera,
                      child: Text("Sky"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 11, 11, 101),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _pickSkyImageFromGallery,
                      child: Text("Sky"),
                    ),
                  ],
                ),
              ],
            ),   
            SizedBox(height: 30),
            ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 8, 109, 25),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _analyzeimages,
                      child: Text("Analyze Images"),
                    ),
                    ValueListenableBuilder<double>(
                    valueListenable: _progress,
                    builder: (context, value, child) {
                      return LinearProgressIndicator(
                        value: value,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      );
                    },
                  ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(results,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Text(_currentDate,style: TextStyle(fontSize: 16),),
                    Text(_currentTime,style: TextStyle(fontSize: 16),),
                    Text( _displayTurbidity,style: TextStyle(fontSize: 16),),
                    Text(_displayspm,style: TextStyle(fontSize: 16),),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OtherParams()),);
                  },
                  child: Text('Back'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForelUleSlider()),);
                  },
                  child: Text('Next'),
                ),
                ElevatedButton(
            onPressed: selectResume,
            child: const Text('Upload'),
          ),
              ],
            ),
          ],
        ),
        
      ),
    );
  }
  
  Future _pickWaterImageFromGallery() async 
  {
   final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
   
   if(returnedImage == null) return;
   setState(() 
   {
     globals.globalCameraWaterImage = File(returnedImage.path);
   });
  }

  Future _pickCardImageFromGallery() async {
   final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
   
   if(returnedImage == null) return;
   setState(() {
     globals.globalCameraCardImage = File(returnedImage.path);
   });
  }

  Future _pickSkyImageFromGallery() async {
   final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
   
   if(returnedImage == null) return;
   setState(() {
     globals.globalCameraSkyImage = File(returnedImage.path);
   });
  }

  Future _pickWaterImageFromCamera() async 
  {
   final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
   
   if(returnedImage == null) return;
   setState(() {
     globals.globalCameraWaterImage = File(returnedImage.path);
   });
  }
  Future _pickCardImageFromCamera() async 
  {
   final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
   
   if(returnedImage == null) return;
   setState(() {
     globals.globalCameraCardImage = File(returnedImage.path);
   });
  }
  Future _pickSkyImageFromCamera() async 
  {
   final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
   
   if(returnedImage == null) return;
   setState(() {
     globals.globalCameraSkyImage = File(returnedImage.path);
   });
  }

}