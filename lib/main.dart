import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logistx/providers/FirestoreProvider.dart';
import 'package:logistx/screen/auth/presentation/pages/forgot_password.dart';
import 'package:logistx/screen/auth/presentation/pages/registration.dart';
import 'package:logistx/screen/auth/presentation/pages/sign_in.dart';
import 'package:logistx/screen/auth/view_model/OTPProvider.dart';
import 'package:logistx/screen/auth/view_model/auth_provider.dart';
import 'package:logistx/providers/visibility_provider.dart';
import 'package:logistx/screen/pages/home_page.dart';
import 'package:logistx/screen/pages/view_model/hpme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OTPProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => FirestoreProvider()),
        ChangeNotifierProvider(create: (context) => VisibilityProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: _router,
        //home: SignInScreen(),
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SignInScreen(),
      routes: [
        GoRoute(path: '/forgot', builder: (context, state) => ForgotPassword(),
        routes: [
        ]
        ),
        GoRoute(path: '/signup', builder: (context, state) => SignUpScreen()),
      ],
    ),
    GoRoute(path: '/sign', builder: (context, state) => SignUpScreen()),
    GoRoute(path: '/home_page', builder: (context, state) => HomePage()),
    GoRoute(path: '/home_page', builder: (context, state) => HomePage()),
    GoRoute(path: '/home_page', builder: (context, state) => HomePage()),
    GoRoute(path: '/home_page', builder: (context, state) => HomePage()),
  ],
);
