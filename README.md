# AquaLens - Water Quality Monitoring App
AquaLens is a flutter-based Android application designed to measure water quality parameters such as Suspended Particulate Matter (SPM) and Turbidity using citizen science and remote sensing technologies. This app empowers users to contribute to environmental monitoring by collecting and analyzing water quality data.

## **Conceptual Understanding of Water Quality Parameter Measurements**
Before diving into the development of AquaLens, it’s essential to understand the **general principles** behind measuring the two key water quality parameters: **Turbidity** and **Suspended Particulate Matter (SPM)**. These parameters are critical for assessing water quality and are measured using **remote sensing techniques** combined with **image analysis**.

### **1. Turbidity**
**Turbidity** is a measure of the **clarity** or **cloudiness** of water, caused by the presence of suspended particles such as silt, clay, organic matter, and microorganisms. High turbidity levels can indicate pollution or the presence of harmful substances in the water.

#### **How Turbidity is Measured**:
1. **Light Scattering Principle**:
   - Turbidity is measured by analyzing how light interacts with suspended particles in the water.
   - When light passes through water, suspended particles scatter the light in different directions. The more particles present, the more light is scattered, and the higher the turbidity.
2. **Remote Sensing Approach**:
   - In AquaLens, turbidity is estimated using **remote sensing reflectance** derived from images of the water surface.
   - A camera captures images of the water, and the app analyzes the light reflected from the water surface.
   - The reflectance values are then used to calculate turbidity based on empirical relationships derived from scientific studies.
3. **Units of Measurement**:
   - Turbidity is typically measured in **Nephelometric Turbidity Units (NTU)**.

### **2. Suspended Particulate Matter (SPM)**
**Suspended Particulate Matter (SPM)** refers to the concentration of solid particles suspended in water. These particles can include soil, organic matter, and other debris. High SPM levels can affect water quality, aquatic ecosystems, and human health.

#### **How SPM is Measured**
1. **Relationship with Turbidity**:
   - SPM is closely related to turbidity because both depend on the concentration of suspended particles in the water.
   - In AquaLens, SPM is calculated indirectly using turbidity measurements.
2. **Empirical Formula**:
   - Scientific studies have established a relationship between turbidity and SPM. This relationship is used to estimate SPM from turbidity values.
   - The formula used in AquaLens is:
     \[
     \text{SPM} = 10^{(1.02 \times \log_{10}(\text{Turbidity}) - 0.04)}
     \]
   - This formula converts turbidity (in NTU) to SPM (in mg/L).
3. **Units of Measurement**:
   - SPM is typically measured in **milligrams per liter (mg/L)**.
### **3. General Workflow in AquaLens**
1. **Image Capture**:
   - The app captures three images:
     - **Water Image**: To measure light reflected from the water surface.
     - **Gray Card Image**: To measure incident light (used as a reference).
     - **Sky Image**: To correct for light reflected from the sky.
2. **Image Analysis**:
   - The app analyzes the pixel values of the images to calculate **remote sensing reflectance**.
   - Reflectance values are used to estimate turbidity and SPM.
3. **Display Results**:
   - The calculated values for turbidity and SPM are displayed in the app, providing users with real-time water quality data.

### **4. Why These Measurements Matter**
- **Environmental Monitoring**: Turbidity and SPM are key indicators of water quality and can help identify pollution sources.
- **Public Health**: High turbidity and SPM levels can affect the safety of drinking water and aquatic ecosystems.
- **Citizen Science**: AquaLens empowers users to contribute to environmental monitoring by collecting and sharing water quality data.

## Developing a Flutter Project Using Visual Studio Code
This guide will walk you through the steps to set up, develop, and run a Flutter project using Visual Studio Code (VS Code). Follow these steps to get started:

**Step 1: Install Flutter and Dart SDK**
1. **Download Flutter SDK:**
   - Visit the official Flutter website: https://flutter.dev.
   - Download the Flutter SDK for your operating system (Windows, macOS, or Linux).
2. **Extract the Flutter SDK:**
   - Extract the downloaded Flutter SDK to a location on your system (e.g., C:\flutter on Windows or /Users/youra-username/flutter on macOS/Linux).
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
     
**Step 2: Add Firebase to Your Flutter Project**
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
**Step 3: Add Firebase Dependencies to Flutter**
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

## **App Demo & Screenshots**
1. **Screenshots:**
   - Below are some screenshots showcasing the key features and user interface of AquaLens:
<div align="center">
  <img src="assets/images/Animation.gif" alt="App Demo">
</div>

2. **Demo Video**
[Watch the demo video here](./Demo.mp4)

## **Technologies**
- **Flutter**: For cross-platform mobile app development.
- **Dart**: The programming language used for Flutter.
- **Google Firebase**: For backend services including authentication, database, and firebase storage.
- **OpenCV**: For image processing and analysis.
