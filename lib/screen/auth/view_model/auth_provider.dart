import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logistx/router/service/network_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _token;
  User? _username;
  String? _userId;

  String? get userId => _userId;
  User? get user => _username;
  bool? get isLoggedIn => _username != null;
  String? get token => _token;
  //id olish

  // Google Sign In
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return "Google sign in canceled";

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      DocumentSnapshot userDoc =
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .get();
      if (!userDoc.exists) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'fullName': googleUser.displayName ?? '',
          'username': googleUser.email.split('@')[0],
          'email': googleUser.email,
          'createdAt': DateTime.now(),
        });
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // ign Out (Chiqish)
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> register({
    required String email,
    required String userName,
    required String password,
    required String fullName,
    required String deviceId,
    required String role,
  }) async {
    final result = await ClientService.post(
      api: ClientService.register,
      data: {
        "email": email,
        "username": userName,
        "password": password,
        "fullName": fullName,
        "deviceId": deviceId,
        "role": role,
      },
    );
    if (result != null) {
      // ignore: unused_local_variable
      final data = jsonDecode(result);
      debugPrint("${result}");
      return data['meta']!['userId'].toString();
    }
    return null;
  }

  Future<void> signIn({
    required String email,
    required String password,
    required String role,
  }) async {
    final response = await ClientService.post(
      api: ClientService.login,
      data: {"email": email, "password": password, "role": role},
    );
    if (response != null) {
      // ignore: unused_local_variable
      final data = jsonDecode(response);
      debugPrint("${response}");
    }
  }

  Future<void> veriy({
    required String email,
    required String password,
    required String deviseId,
    required int id,
    required String userName,
    required String code,
  }) async {
    final response = await ClientService.post(
      api: ClientService.verify,
      data: {
        "email": email,
        "username": userName,
        "password": password,
        "deviseId": deviseId,
        "id": id,
        "code": code,
      },
    );
    if (response != null) {
      // ignore: unused_local_variable
      final data = jsonDecode(response);
    //  debugPrint("${response}");
    }
  }

  Future<String?> getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // Android ID
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor; // iOS ID
    }
    return null;
  }

  // **updatePassword
  Future<void> update({required String email, required String password}) async {
    final response = await ClientService.put(
      api: ClientService.updatePassword,
      param: {"email": email, "newPassword": password},
    );
    if (response != null) {
      // ignore: unused_local_variable
      final date = jsonDecode(response);
     // debugPrint("${date}");
    }
  }

}
