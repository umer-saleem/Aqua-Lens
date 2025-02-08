import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_picker/analyzecameraimgs.dart';
import 'globals.dart' as globals;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),),
      debugShowCheckedModeBanner: false,
      home: const ForelUleSlider()
    );
  }
}

class ForelUleSlider extends StatefulWidget {
  const ForelUleSlider({ Key? key }) : super(key: key);

  @override
  State<ForelUleSlider> createState() => _ForelUleSliderState();
}

class _ForelUleSliderState extends State<ForelUleSlider> {
  double _currentValue = 0;

  final List<Color> colors = [
    Color.fromARGB(255,33,88,188),//1
    Color.fromARGB(255,49,109,197),//2
    Color.fromARGB(255,50,124,187),//3
    Color.fromARGB(255,75,128,160),//4
    Color.fromARGB(255,86,143,150),//5
    Color.fromARGB(255,109,146,152),//6
    Color.fromARGB(255,105,140,134),//7
    Color.fromARGB(255,117,158,114),//8
    Color.fromARGB(255,123,166,84),//9
    Color.fromARGB(255,125,174,56),//10
    Color.fromARGB(255,149,182,69),//11
    Color.fromARGB(255,148,182,96),//12
    Color.fromARGB(255,165,188,118),//13
    Color.fromARGB(255,170,184,109),//14
    Color.fromARGB(255,173,181,95),//15
    Color.fromARGB(255,168,169,101),//16
    Color.fromARGB(255,174,159,92),//17
    Color.fromARGB(255,179,160,83),//18
    Color.fromARGB(255,175,138,68),//19
    Color.fromARGB(255,164,105,5),//20
    Color.fromARGB(255,161,77,4),//21

    // Add more colors as needed for the Forel-Ule scale
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('AquaLens'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text("Color Analysis",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),
               const SizedBox(height: 10,),
               Container(
                width: 250,
                height: 180,
                decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                ),
                
                child: globals.globalCameraWaterImage != null
                  ? Image.file(globals.globalCameraWaterImage!,fit: BoxFit.cover)
                  : Center(),
              ),
              Text("Waterbody Image ",style: TextStyle(fontSize: 16),),
          Slider(
            value: _currentValue,
            min: 0,
            max: (colors.length - 1).toDouble(),
            divisions: colors.length - 1,
            onChanged: (double value) {
              setState(() {
                _currentValue = value;
              });
            },
            activeColor: colors[_currentValue.toInt()],
            inactiveColor: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: colors
                .asMap()
                .entries
                .map((entry) => _buildColorBox(entry.key, entry.value))
                .toList(),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Selected FU Value: ",style: TextStyle(fontSize: 16),),
              Text('${_currentValue + 1}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
            ],),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AnalyzeImages()),);
                  },
                  child: Text('Back'),
                ),
              ],
            ),
            
        ],
      ),
    );
  }

  Widget _buildColorBox(int index, Color color) {
    return Column(
      children: [
        Container(
          width: 15,
          height: 40,
          color: color,
        ),
        Text(
          '${index + 1}',
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
