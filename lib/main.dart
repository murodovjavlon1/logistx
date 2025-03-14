import 'package:flutter/material.dart';
import 'package:logistx/providers/FirestoreProvider.dart';
import 'package:logistx/screen/auth/view_model/OTPProvider.dart';
import 'package:logistx/screen/auth/view_model/auth_provider.dart';
import 'package:logistx/providers/visibility_provider.dart';
import 'package:logistx/screen/auth/presentation/pages/sign_in.dart';
import 'package:logistx/screen/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OTPProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => FirestoreProvider()),
        ChangeNotifierProvider(create: (context) => VisibilityProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomePage(),
      ),
    );
  }
}
