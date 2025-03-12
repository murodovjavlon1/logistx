import 'package:flutter/material.dart';
import 'package:logistx/providers/visibility_provider.dart';
import 'package:logistx/screen/auth/registration.dart';
import 'package:provider/provider.dart';
import 'package:logistx/providers/auth_provider.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isRegistering = false;

  bool isPasswordVisible = false;

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 150),
              // **Registration toggle**
              Text(
                "Sign In",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),

              SizedBox(height: 10),
              Text(
                "Welcome back! Please sign in to continue.",
                style: TextStyle(color: Colors.black38),
              ),
              SizedBox(height: 20),
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: emailController,
                // keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                ),
              ),
              SizedBox(height: 15),
              // **Email Field**
              Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              TextFormField(
                controller: passwordController,
                obscureText:
                    context
                        .watch<VisibilityProvider>()
                        .isObscured, // Provider bilan bog‘ladik
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  suffixIcon: Consumer<VisibilityProvider>(
                    // Consumer ishlatilmoqda
                    builder: (context, visibility, child) {
                      return IconButton(
                        icon: Icon(
                          visibility.isObscured
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          visibility
                              .toggleVisibility(); // Provider orqali holatni o'zgartiramiz
                        },
                      );
                    },
                  ),
                ),
              ),

              // **Forgot Password**
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // **Sign In Button**
              buildButton("Sign In", Colors.blue, () async {}),

              SizedBox(height: 10),

              // **Don't have an account? Sign up**
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              Row(
                children: [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Or continue with Google"),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),

              SizedBox(height: 10),

              // **Google Sign In Button**
              buildButton("Sign In With Google", Colors.white, () async {
                String? error = await authProvider.signInWithGoogle();
                if (error != null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(error)));
                }
              }, google: true),
            ],
          ),
        ),
      ),
    );
  }

  // **Button builder**
  Widget buildButton(
    String text,
    Color color,
    VoidCallback onPressed, {
    bool google = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: google ? Colors.white : color,
          foregroundColor: google ? Colors.black : Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child:
            google
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SizedBox(width: 10), Text(text)],
                )
                : Text(text, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

