# 🌾 Farmer Subsidy Application

A Flutter-based **Farmer Subsidy Application Form** that allows farmers to enter their personal, address, farm, bank, and subsidy details and submit an application after completing all required validations.

The application is designed with a simple and user-friendly interface and can be run directly using **FlutLab** or any Flutter development environment.

---

## 📌 Project Overview

The **Farmer Subsidy Application** is a mobile application developed using Flutter.

The application collects important farmer information such as:

* Farmer Name
* Aadhaar Number
* Mobile Number
* State
* District
* Village
* Land Area
* Crop
* Bank Account Number
* IFSC Code
* Subsidy Scheme
* Declaration

Before submission, the application validates the entered information and displays an application-success message when all required fields are valid.

---

## 🎯 Objectives

The main objectives of this project are:

1. To create a simple digital farmer subsidy application form.
2. To provide input validation for important farmer details.
3. To validate Aadhaar numbers using a 12-digit format.
4. To validate Indian mobile numbers using a 10-digit format.
5. To validate IFSC codes using the standard IFSC format.
6. To provide state and district selection.
7. To provide crop and subsidy scheme selection.
8. To prevent submission when required information is missing.
9. To provide a simple and responsive Flutter UI.
10. To demonstrate Flutter form handling and validation.

---

## ✨ Features

### 👨‍🌾 Farmer Details

The application accepts:

* Farmer name
* Aadhaar number
* Mobile number

### 📍 Address Details

Users can select:

* State
* District
* Village

The district list changes according to the selected state.

### 🌱 Farm Details

Farmers can enter:

* Land area in acres
* Crop type

Available crops include:

* Rice
* Wheat
* Maize
* Cotton
* Sugarcane
* Groundnut
* Vegetables
* Pulses

### 🏦 Bank Details

The application accepts:

* Bank account number
* IFSC code

The IFSC code is automatically converted to uppercase.

### 💰 Subsidy Details

Available subsidy schemes include:

* PM-KISAN
* Crop Subsidy Scheme
* Fertilizer Subsidy
* Seed Subsidy
* Irrigation Subsidy
* Farm Equipment Subsidy

### ✅ Validation

The application validates:

* Farmer name
* Aadhaar number
* Mobile number
* State
* District
* Village
* Land area
* Crop
* Account number
* IFSC code
* Subsidy scheme
* Declaration

### 🔄 Reset

The **Reset** button clears all entered information and returns the form to its initial state.

### 📤 Submit

The **Submit Application** button checks all required fields.

If the information is valid, a success dialog is displayed:

> Application Submitted

---

## 🛠️ Technologies Used

| Technology      | Purpose                                |
| --------------- | -------------------------------------- |
| Flutter         | Application development                |
| Dart            | Programming language                   |
| Material Design | User interface                         |
| FlutLab         | Online Flutter development environment |

---

## 📱 Application UI

The application contains the following major sections:

### 1. Application Header

Displays:

* Agriculture icon
* Farmer Subsidy Application title
* Short application description

### 2. Farmer Details

Contains:

* Farmer Name
* Aadhaar Number
* Mobile Number

### 3. Address Details

Contains:

* State dropdown
* District dropdown
* Village

### 4. Farm Details

Contains:

* Land Area
* Crop selection

### 5. Bank Details

Contains:

* Account Number
* IFSC Code

### 6. Subsidy Details

Contains:

* Subsidy Scheme dropdown

### 7. Declaration

The farmer must accept the declaration before submitting the application.

### 8. Action Buttons

The application provides:

* Reset
* Submit Application

---

## 🔐 Validation Rules

### Aadhaar Validation

The Aadhaar number must:

* Contain exactly 12 digits
* Contain numbers only

Example:

```text
123456789012
```

### Mobile Number Validation

The mobile number must:

* Contain exactly 10 digits
* Start with a digit from 6 to 9

Example:

```text
9876543210
```

### Account Number Validation

The bank account number must:

* Contain only digits
* Have between 9 and 18 digits

### IFSC Validation

The IFSC code follows the format:

```text
AAAA0XXXXXX
```

Example:

```text
SBIN0001234
```

The application automatically converts lowercase characters into uppercase.

### Land Area Validation

The land area must:

* Be a valid number
* Be greater than zero

Example:

```text
2.5
```

### Declaration Validation

The user must select the declaration checkbox before submitting the application.

---

## 📂 Project Structure

```text
farmer_subsidy_application/
│
├── lib/
│   └── main.dart
│
├── pubspec.yaml
│
└── README.md
```

### `main.dart`

Contains the complete Flutter application including:

* Application entry point
* UI
* Input fields
* Dropdowns
* Validation
* Submit functionality
* Reset functionality
* Success dialog

### `pubspec.yaml`

Contains the Flutter project configuration.

This project does not require any third-party package.

---

## 🚀 How to Run the Project

### Using FlutLab

1. Open **FlutLab**.
2. Create a new Flutter project.
3. Open:

```text
lib/main.dart
```

4. Remove the existing code.
5. Paste the project `main.dart` code.
6. Make sure `pubspec.yaml` contains the required Flutter configuration.
7. Run the project.
8. The Farmer Subsidy Application will appear in the preview.

---

## 🧪 Testing the Application

You can test the application using sample information.

### Sample Input

| Field          | Sample Value     |
| -------------- | ---------------- |
| Farmer Name    | Ramesh Kumar     |
| Aadhaar        | 123456789012     |
| Mobile         | 9876543210       |
| State          | Andhra Pradesh   |
| District       | Bhimavaram       |
| Village        | Ramachandrapuram |
| Land Area      | 2.5              |
| Crop           | Rice             |
| Account Number | 123456789012     |
| IFSC           | SBIN0001234      |
| Subsidy Scheme | PM-KISAN         |
| Declaration    | Checked          |

After entering all the details, click:

```text
Submit Application
```

A success dialog will be displayed.

---

## ❌ Invalid Input Examples

### Invalid Aadhaar

```text
12345
```

Result:

```text
Aadhaar must contain exactly 12 digits
```

### Invalid Mobile Number

```text
1234567890
```

Result:

```text
Enter a valid 10-digit mobile number
```

### Invalid IFSC

```text
ABC123
```

Result:

```text
Enter a valid IFSC code
```

### Empty State

If the state is not selected:

```text
Please select state
```

### Empty Declaration

If the declaration is not accepted:

```text
Please accept the declaration
```

---

## 🔄 Application Flow

```text
Start Application
       │
       ▼
Enter Farmer Details
       │
       ▼
Enter Address Details
       │
       ▼
Enter Farm Details
       │
       ▼
Enter Bank Details
       │
       ▼
Select Subsidy Scheme
       │
       ▼
Accept Declaration
       │
       ▼
Click Submit
       │
       ▼
Validate Information
       │
       ├───────────────┐
       │               │
    Invalid           Valid
       │               │
       ▼               ▼
Show Error       Submit Application
                       │
                       ▼
                Success Message
```

---

## 🎨 UI Design

The application uses Flutter Material Design components.

The interface includes:

* Green agricultural theme
* Rounded cards
* Input fields
* Dropdown menus
* Icons
* Responsive layout
* Scrollable form
* Success dialog
* Error SnackBars

The green color theme represents agriculture and farming.

---

## 📋 Main Flutter Components Used

The project uses Flutter widgets such as:

```dart
MaterialApp
Scaffold
AppBar
SingleChildScrollView
Column
Row
Container
TextField
DropdownButtonFormField
Checkbox
ElevatedButton
OutlinedButton
AlertDialog
SnackBar
```

---

## 🔧 Input Formatting

The application uses Flutter's built-in input formatters.

For Aadhaar:

```dart
FilteringTextInputFormatter.digitsOnly
```

For mobile:

```dart
FilteringTextInputFormatter.digitsOnly
```

For account number:

```dart
FilteringTextInputFormatter.digitsOnly
```

For IFSC:

```dart
UpperCaseFormatter()
```

This ensures that the entered information follows the expected format.

---

## 📦 Dependencies

This project does not use external Flutter packages.

The application uses only Flutter's built-in libraries:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
```

Therefore, no additional package installation is required.

---

## 🔮 Future Enhancements

The current application is a frontend form-based prototype. The following features can be added in future versions:

### Backend Integration

Connect the application to a backend server such as:

* Node.js
* Express.js
* Firebase
* Django

### Database

Store farmer applications in:

* Firebase Firestore
* MySQL
* PostgreSQL
* MongoDB

### Authentication

Add:

* Farmer login
* Registration
* OTP verification
* Aadhaar-based authentication

### Application Tracking

Farmers could check:

```text
Application Submitted
        ↓
Under Verification
        ↓
Approved / Rejected
        ↓
Subsidy Processed
```

### Document Upload

Allow farmers to upload:

* Aadhaar document
* Land ownership document
* Bank passbook
* Crop documents
* Other supporting documents

### Admin Dashboard

An administrator could:

* View applications
* Verify farmer details
* Approve applications
* Reject applications
* Track subsidy distribution

### Notifications

Add notifications for:

* Application submission
* Verification
* Approval
* Rejection
* Subsidy payment

---

## 🔒 Privacy and Security

This project is currently a frontend demonstration application.

The current version does **not** store submitted farmer information in a database.

For a production application, sensitive information such as Aadhaar and bank details should be handled securely using:

* HTTPS
* Secure backend APIs
* Authentication
* Authorization
* Encryption
* Secure database storage
* Appropriate privacy and data-protection controls

---

## 🎓 Learning Outcomes

By developing this project, the following Flutter concepts can be learned:

* Creating Flutter applications
* Creating StatefulWidgets
* Managing TextEditingControllers
* Handling user input
* Creating dropdown menus
* Managing application state
* Input validation
* Regular expressions
* Input formatters
* Showing SnackBars
* Showing AlertDialogs
* Creating reusable UI widgets
* Handling button events
* Building responsive layouts

---

## 👩‍💻 Author

**VASIREDDY DIXITA**

B.Tech – Computer Science and Engineering

Vishnu Institute of Technology, Bhimavaram

---

## 📄 License

This project is created for **educational and academic purposes**.

You are free to modify and extend the project for learning and demonstration purposes.

---

## ⭐ Conclusion

The **Farmer Subsidy Application** demonstrates how Flutter can be used to create a simple, responsive, and validated digital application form.

The project focuses on collecting farmer information, validating important fields such as Aadhaar, mobile number and IFSC code, allowing subsidy selection, and providing a clear submission workflow.

The application can be further extended with a backend, database, authentication, document verification, admin dashboard, and real-time application tracking to create a complete digital farmer subsidy management system.

