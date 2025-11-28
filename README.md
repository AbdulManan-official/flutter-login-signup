Flutter Login & Signup with Firebase (task_login)

A Flutter app demonstrating Login & Signup screens with Firebase Authentication and Firestore integration, proper form validations, password strength checks, and navigation between screens.

Project Description

This Flutter application allows users to:

Login with Email & Password (only if previously signed up)

Signup with Name, Email, Password, and Confirm Password (new users only)

Store user information in Firestore under the users collection

Navigate between Login and Signup screens

View form validation errors in real-time

See success or error messages via SnackBars

Toggle password visibility for security

Password fields appear black in screen recordings for privacy

It is designed to test understanding of Flutter basics, Firebase Auth, Firestore, forms, validation, and UI design.

Features

Login Screen:

Email & Password fields with real-time validations

Users can login only if email exists in Firebase Auth

Signup Screen:

Name, Email, Password, Confirm Password fields with validations

Password strength check:

Minimum 8 characters

Uppercase & lowercase letters

Numbers

Special characters

New user emails are registered in Firebase Auth and stored in Firestore users collection

Navigation:

Login → Signup

Signup → Login

UI/UX Enhancements:

Custom InputField widget

Password visibility toggle

Styled buttons

SnackBars for success/error messages

Mobile-responsive design

Error Handling:

Proper handling of Firebase Auth exceptions

Displays user-friendly error messages

Packages Used

firebase_core: ^4.2.1

firebase_auth: ^6.1.2

cloud_firestore: ^6.1.0

Project Structure
lib/
├── main.dart
├── screens/
│   ├── login_screen.dart
│   └── signup_screen.dart
├── widgets/
│   └── inputfield.dart
└── assets/
    ├── login.png
    └── signup.png
Getting Started
Prerequisites

Flutter SDK installed

Git installed

Firebase project setup (with Android app linked)

Installation

Clone the repository:

git clone https://github.com/AbdulManan-official/flutter-login-signup.git

Navigate to the project folder:

cd flutter-login-signup

Install dependencies:

flutter pub get

Run the app:

flutter run
Notes

Tested on Flutter 3.x or above

UI is mobile responsive

Password fields are masked for privacy, especially during recordings

Firestore stores additional user info during signup

Replace images in assets/ as needed

Resources

Flutter Documentation

Flutter Codelabs

Flutter Cookbook

Firebase Flutter Documentation

Hashtags / Tags

#Flutter #Firebase #FirebaseAuth #CloudFirestore #FlutterDev #MobileAppDevelopment #RealTimeLogin #UserAuthentication #FlutterAndroid #AppDevelopment #FirestoreUsers #ErrorHandling #SignUp #FlutterFirebase
