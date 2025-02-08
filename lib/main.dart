import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_picker/citizenscience.dart';
import 'package:firebase_core/firebase_core.dart';
import 'globals.dart' as globals;

Future<void> main() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAmZem308dI6Zwsyf72mxoQ9iOarxTS0DY",
      authDomain: "webdatauploadtest.firebaseapp.com",
      projectId: "webdatauploadtest",
      storageBucket: "webdatauploadtest.appspot.com",
      messagingSenderId: "423814741376",
      appId: "1:423814741376:web:56bc91269d417a9116d565",
      measurementId: "G-2G5SQG7L07"
        ),);
  }
  else{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAmZem308dI6Zwsyf72mxoQ9iOarxTS0DY",
      authDomain: "webdatauploadtest.firebaseapp.com",
      projectId: "webdatauploadtest",
      storageBucket: "webdatauploadtest.appspot.com",
      messagingSenderId: "423814741376",
      appId: "1:423814741376:web:56bc91269d417a9116d565",
      measurementId: "G-2G5SQG7L07"
        ),);
  }
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
      home: const SignUpPage()
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({ Key? key }) : super(key: key);

  @override
  State<SignUpPage> createState() => _HomeState();
}

class _HomeState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('AquaLens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: globals.nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: globals.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  if (!value.contains('.com')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: globals.passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 15) {
                    return 'Password must be at least 15 characters long';
                  }
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return 'Password must contain at least one lowercase letter';
                  }
                  if (!RegExp(r'\d').hasMatch(value)) {
                    return 'Password must contain at least one number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Perform sign-up action here.
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CitizenScience()),);
                  }
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
