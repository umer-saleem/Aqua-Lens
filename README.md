# AquaLens - Water Quality Monitoring App

AquaLens is a flutter-based Android application designed to measure water quality parameters such as Suspended Particulate Matter (SPM) and Turbidity using citizen science and remote sensing technologies. This app empowers users to contribute to environmental monitoring by collecting and analyzing water quality data.

## Developing a Flutter Project Using Visual Studio Code
This guide will walk you through the steps to set up, develop, and run a Flutter project using Visual Studio Code (VS Code). Follow these steps to get started:

**Step 1: Install Flutter and Dart SDK**
1. **Download Flutter SDK:**
   - Visit the official Flutter website: https://flutter.dev.
   - Download the Flutter SDK for your operating system (Windows, macOS, or Linux).
2. **Extract the Flutter SDK:**
   - Extract the downloaded Flutter SDK to a location on your system (e.g., C:\flutter on Windows or /Users/your-username/flutter on macOS/Linux).
3. **Add Flutter to PATH:**
   - Add the Flutter SDK's bin directory to your system's PATH environment variable.
   - Example (for macOS/Linux):<br/>
     ```export PATH="$PATH:`pwd`/flutter/bin"```
   - Example (for Windows): Open Environment Variables and add ```C:\flutter\bin``` to the PATH.
4. **Verify Installation:**
   - Run the following command to verify the installation:<br/>
     ```flutter doctor```

**Step 2: Install Visual Studio Code**
1. **Download and Install VS Code:**
   - Visit the official VS Code website: https://code.visualstudio.com.
   - Download and install VS Code for your operating system.
2. **Install Flutter and Dart Extensions:**
   - Open VS Code and go to the Extensions Marketplace (Ctrl+Shift+X or Cmd+Shift+X on macOS).
   - Search for and install the following extensions:
     * Flutter (by Dart Code)
     * Dart (by Dart Code)
       
**Step 3: Create a New Flutter Project**
1. **Open VS Code:**
   - Launch Visual Studio Code.
2. **Create a New Flutter Project:**
   - Open the Command Palette (```Ctrl+Shift+P``` or ```Cmd+Shift+P``` on macOS).
   - Type and select **Flutter: New Project**.
   - Choose Application as the project type.
   - Enter a project name (e.g., **my_flutter_app**).
   - Select a location to save the project.
3. **Navigate to the Project Directory:**
   - Open the terminal in VS Code (```Ctrl+``` or ```Cmd+``` on macOS).
   - Navigate to the project directory: ```cd my_flutter_app```
  
**Step 4: Run the Flutter Project**
1. **Connect a Device or Emulator:**
   - Connect a physical device via USB or start an emulator.
   - To start an emulator, run: ```flutter emulators --launch <emulator_name>```. **Example:** ```flutter emulators --launch Pixel_4_API_30```
2. **Run the Project:**
   - In the terminal, run the following command to start the app:<br/> ```flutter run```
   - Alternatively, press ```F5``` in VS Code to run the project in debug mode.
  
**Step 5: Develop Your Flutter App**
1. **Edit Code:**
   - Open the lib/main.dart file in VS Code.
   - Modify the code to build your app.
2. **Hot Reload:**
   - Save your changes (```Ctrl+S``` or ```Cmd+S``` on macOS).
   - Use Hot Reload (press ```r``` in the terminal or click the 🔥 icon in VS Code) to see changes instantly.

**Step 6: Debugging and Testing**
1. **Debugging:**
   - Set breakpoints in your code by clicking the left gutter in VS Code.
   - Press ```F5``` to start debugging.
2. **Testing:**
   - Write unit and widget tests in the test directory.
   - Run tests using: <br/> ```flutter test```

## **Setting Up Firebase for a Flutter Application (Android Only)**

**Step 1: Create a Firebase Project**
1. **Go to Firebase Console**:
   - Visit the [Firebase Console](https://console.firebase.google.com/).
   - Click on **"Add Project"** and follow the steps to create a new Firebase project.
2. **Add Firebase to Your Android App**:
   - In the Firebase Console, click on the **Android icon** to add an Android app to your project.
   - Enter your app's package name (e.g., `com.example.my_flutter_app`).
   - Download the `google-services.json` file.
## **Step 2: Add Firebase to Your Flutter Project**
1. **Place `google-services.json` in Your Project**:
   - Copy the downloaded `google-services.json` file.
   - Paste it into the `android/app` directory of your Flutter project.
2. **Update `android/build.gradle`**:
   - Open the `android/build.gradle` file.
   - Add the following lines inside the `buildscript` block:
     ```gradle
     buildscript {
         dependencies {
             // Add the Google services classpath
             classpath 'com.google.gms:google-services:4.3.10'
         }
     }
     ```
3. **Update `android/app/build.gradle`**:
   - Open the `android/app/build.gradle` file.
   - Add the following line at the bottom of the file:
     ```gradle
     apply plugin: 'com.google.gms.google-services'
     ```
## **Step 3: Add Firebase Dependencies to Flutter**
1. **Add Firebase Packages**:
   - Open the `pubspec.yaml` file in your Flutter project.
   - Add the following dependencies:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       firebase_core: latest_version
     ```
   - Replace `latest_version` with the latest version of the `firebase_core` package (check [pub.dev](https://pub.dev) for the latest version).
2. **Install Dependencies**:
   - Run the following command in the terminal to install the dependencies:
     ```bash
     flutter pub get
     ```
## **Step 4: Initialize Firebase in Your Flutter App**
1. **Import Firebase Packages**:
   - Open the `lib/main.dart` file.
   - Add the following import at the top:
     ```dart
     import 'package:firebase_core/firebase_core.dart';
     ```
2. **Initialize Firebase**:
   - Modify the `main` function to initialize Firebase:
     ```dart
     void main() async {
       WidgetsFlutterBinding.ensureInitialized();
       await Firebase.initializeApp();
       runApp(MyApp());
     }
     ```
## **Step 5: Run Your Flutter App**
1. **Connect a Device or Emulator**:
   - Connect a physical Android device or start an Android emulator.
2. **Run the App**:
   - In the terminal, run the following command:
     ```bash
     flutter run
     ```
## **Step 6: Verify Firebase Integration**
1. **Check Firebase Initialization**:
   - Add a print statement in the `main` function to verify Firebase initialization:
     ```dart
     void main() async {
       WidgetsFlutterBinding.ensureInitialized();
       await Firebase.initializeApp();
       print('Firebase initialized successfully');
       runApp(MyApp());
     }
     ```
2. **Run the App**:
   - Check the console output to ensure Firebase is initialized successfully.
## **Step 7: Add Additional Firebase Services (Optional)**
1. **Add Firebase Authentication**:
   - Add the `firebase_auth` package to your `pubspec.yaml` file:
     ```yaml
     dependencies:
       firebase_auth: latest_version
     ```
   - Run `flutter pub get` to install the package.
2. **Add Firebase Firestore**:
   - Add the `cloud_firestore` package to your `pubspec.yaml` file:
     ```yaml
     dependencies:
       cloud_firestore: latest_version
     ```
   - Run `flutter pub get` to install the package.
## **Step 8: Deploy Your App**
1. **Build the APK**:
   - Run the following command to build the APK:
     ```bash
     flutter build apk
     ```
2. **Deploy to Google Play Store**:
   - Follow the official Flutter documentation to deploy your app to the Google Play Store.

## **Screenshots**
Check out the carousel showcasing the app screenshots: 
<div align="center">
  <img src="assets/images/Animation.gif" alt="App Demo">
</div>

## **Technologies**
- **Flutter**: For cross-platform mobile app development.
- **Dart**: The programming language used for Flutter.
- **Google Firebase**: For backend services including authentication, database, and firebase storage.
- **OpenCV**: For image processing and analysis.

## **Demo**
./demo.mp4
