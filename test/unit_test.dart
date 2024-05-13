import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

bool validateEmail(String email) {
  const emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  final RegExp regex = RegExp(emailRegex);

  return regex.hasMatch(email);
}

void main() {
  // Valid Email Unit Test
  
  test('Valid Email Test', () {
    const email = 'test@gmail.com';
    final isValid = validateEmail(email);

    expect(isValid, true);
  });

  test('Valid Email Test', () {
    const email = 'te';
    final isValid = validateEmail(email);
    expect(isValid, true);
  });

// //Empty Email Unit Test
//   test('Empty Email Test', () {
//     const email = '';
//     final isValid = validateEmail(email);
//
//     expect(isValid, false);
//   });
//
//   test('Empty Email Test', () {
//     const email = 'test';
//     final isValid = validateEmail(email);
//
//     expect(isValid, false);
//   });
// //Email with @gmail.com
//   test('Email with top-level domain Test', () {
//     const email = 'test@gmail.com';
//     final isValid = validateEmail(email);
//
//     expect(isValid, true);
//   });
//
//   test('Email with top-level domain Test', () {
//     const email = 'test@gmail';
//     final isValid = validateEmail(email);
//
//     expect(isValid, true);
//   });
}
//
//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// void main() {
//
//   WidgetsFlutterBinding.ensureInitialized();
//   setUpAll(() async {
//     await Firebase.initializeApp();
//   });
//
//
//   group('Firebase Login Integration Test', () {
//     test('Valid Login Test', () async {
//       final auth = FirebaseAuth.instance;
//       final result = await auth.signInWithEmailAndPassword(
//         email: 'test@example.com',
//         password: 'passwordS@123',
//       );
//       expect(result.user, isNotNull);
//     });
//
//     test('Invalid Login Test', () async {
//
//       final auth = FirebaseAuth.instance;
//       final result = await auth.signInWithEmailAndPassword(
//         email: 'invalid@example.com',
//         password: 'wrongpassword',
//       );
//       expect(result.user, isNull);
//     });
//  });
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
//
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   setUp(() async {
//     await Firebase.initializeApp();
//   });
//
//   group('Firebase Sign-Up Integration Test', () {
//     test('Valid Sign-Up Test', () async {
//       final auth = FirebaseAuth.instance;
//       final email = 'raneem212222@egmail.com';
//       final password = 'R@67677';
//       final name = 'Raneem Ahmad';
//
//       final result = await auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       User? user = result.user;
//       if (user != null) {
//         await user.updateDisplayName(name);
//       }
//       expect(user, isNotNull);
//       expect(user!.displayName, name);
//     });
//   });
// }