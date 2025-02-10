import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

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
   
   File? _CameraWaterImage;
   File? _CameraCardImage;
   File? _CameraSkyImage;
   final WaterSurfaceReflectanceFactor = 0.028;
   final GrayCardReflectance = 0.18;

   String _displayTurbidity = '';
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

    if (_CameraWaterImage == null || _CameraCardImage == null || _CameraSkyImage == null) {
      print('Please select all images.');
      return;
    }

    final bytesWaterImage = await _CameraWaterImage!.readAsBytes();
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

    final bytesCardImage = await _CameraCardImage!.readAsBytes();
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

    final bytesSkyImage = await _CameraSkyImage!.readAsBytes();
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
    }
    else
    {
        // From Leeuw and Boss 2018
        Turbidity = (22.57 * reflectanceRed) / (0.044 - reflectanceRed);
        spm = math.pow(10, (1.02 * math.log(Turbidity) / math.log(10) - 0.04));
        Turbidity = double.parse((Turbidity).toStringAsFixed(2));
        spm = double.parse((spm).toStringAsFixed(2));
    }
    await _printTurbidity(Turbidity);

    /*setState(() {
      _reflectanceRed = reflectanceRed.toString();
    });

    Turbidity = 223.49 * RemoteSensingReflectance + 0.2498;
    setState(() {
      _displayTurbidity = Turbidity.toString();
    });

    spm = (0.4893 * Turbidity + 0.0281);
    setState(() {
      _displayspm = spm.toString();
    });*/
  }

  Future<void> _printTurbidity(Turbidity) async {
    final now = DateTime.now();
    setState(() {
      _currentDate = 'Date = ' + _formatDate(now);
      _currentTime = 'Time = ' + _formatTime(now);
      _displayTurbidity = 'Turbidity = $Turbidity NTU';
      _displayspm = 'SPM = $spm mg/L';
      _reflectanceRed = 'Reflectance (Red) = $reflectanceRed';
    });
  }

  Future<void> _pickCameraImage1() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _CameraWaterImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickCameraImage2() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _CameraCardImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickCameraImage3() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _CameraSkyImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _pickCameraImage1,
            child: const Text('Capture Water Image'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _pickCameraImage2,
            child: const Text('Capture Card Image'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _pickCameraImage3,
            child: const Text('Capture Sky Image'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _analyzeimages,
            child: const Text('Analyze Images'),
          ),
          const SizedBox(height: 16),
          Text('Reflectance: $_reflectanceRed'),
          Text('Turbidity: $_displayTurbidity'),
          Text('SPM: $_displayspm'),
        ],
      ),
    );
  }
}
