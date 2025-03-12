import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _token;
  User? _username;

  User? get user => _username;
  bool? get isLoggedIn => _username != null;
  String? get token => _token;

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

  //Sign Up(ro'xat dan O'tish )
  Future<void> signUp(String fullName, String email, String username, String password) async {
    final url = Uri.parse('api.logistx.uz'); // API URL
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          "fullName": fullName,
          "email": email,
          "username": username,
          "password": password
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _token = data['token'];
        await _saveToken(_token!);
        notifyListeners();
      } else {
        throw Exception('Sign Up failed');
      }
    } catch (error) {
      return;
    }
  }


  // Sign In (Kirish)
  Future<void> signIn(String email, String password) async {
    final url = Uri.parse(''); // API URL
    try {
      final response = await http.post(
        url,
        body: jsonEncode({"email": email, "password": password}),
        headers: {'Content-Type': ''},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['token'];
        await _saveToken(_token!);
        notifyListeners();
      } else {
        throw Exception('Sign In failed');
      }
    } catch (error) {
      return;
    }
  }

  // Logout (Chiqish)
  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    notifyListeners();
  }

  // Tokenni saqlash
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Tokenni olish
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    notifyListeners();
  }
}
