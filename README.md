# Flutter Login & Signup (task_login)

A Flutter app demonstrating Login & Signup screens with proper form validations, password strength checks, and navigation between screens.

---

## Project Description

This project is a simple Flutter application that allows users to:

- Login with Email & Password
- Signup with Name, Email, Password, and Confirm Password
- Navigate between Login and Signup screens
- View form validation errors in real-time
- See success or error messages via SnackBars
- Toggle password visibility

It is designed to test understanding of Flutter basics, forms, validation, and UI design.

---

## Features

- **Login Screen**: Email & Password fields with validations
- **Signup Screen**: Name, Email, Password, Confirm Password with validations
- **Password Requirements**:
  - At least 8 characters
  - Includes uppercase & lowercase letters
  - Includes numbers
  - Includes special characters
- **Navigation**:
  - Login → Signup
  - Signup → Login
- **UI/UX**:
  - Custom InputField widget
  - Password visibility toggle
  - Styled buttons
  - SnackBars for success/error messages

---

## Project Structure
lib/
├── main.dart
├── screens/
│ ├── login_screen.dart
│ └── signup_screen.dart
├── widgets/
│ └── inputfield.dart
└── assets/
├── login.png
└── signup.png

## Getting Started

### Prerequisites

- Flutter SDK installed
- Git installed (for version control)

### Installation

1. **Clone the repository:**

git clone https://github.com/AbdulManan-official/flutter-login-signup.git

**Navigate to the project folder:**

cd flutter-login-signup


**Install dependencies:**

flutter pub get


**Run the app:**

flutter run

**Notes**

Tested on Flutter 3.x or above

UI is mobile responsive

Replace images in assets/ as needed

Currently no backend integration; this is a front-end demo with form validation

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Codelabs](https://docs.flutter.dev/get-started/codelab)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)


