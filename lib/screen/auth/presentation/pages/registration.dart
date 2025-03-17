import 'package:flutter/material.dart';
import 'package:logistx/screen/auth/presentation/pages/confirmation.dart';
import 'package:provider/provider.dart';
import 'package:logistx/screen/auth/view_model/auth_provider.dart';



class SignUpScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isRegistering = false;
  String selectedRole = "DRIVER";

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // **Registration toggle**
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Registration",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 20),

              // **Full Name**
              buildTextField("Full Name", fullNameController),

              // **Email**
              buildTextField("Email", emailController),

              // **Role Dropdown**
              buildDropdown(),

              // **Username**
              buildTextField("Username", usernameController),

              // **Password**
              buildTextField("Password", passwordController, isPassword: true),

              SizedBox(height: 20),

              // **Sign Up Button**
              buildButton("Continue", Colors.blue, () async {
               if (
                emailController.text.isNotEmpty||
                fullNameController.text.isNotEmpty||
                usernameController.text.isNotEmpty||
                passwordController.text.isNotEmpty
               
               
               ) {
                 final result = await authProvider.register(
                  email: emailController.text,
                  userName: usernameController.text,
                  password: passwordController.text,
                  fullName: fullNameController.text,
                  deviceId: '12312jnnini123',
                  role: 'DRIVER',
                );
                debugPrint("$result");
               }
               else{
                ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please fill in all the fields"),
                          ),
                        );

               }
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return Confirmation(
                //         password: passwordController.text,
                //         userName: usernameController.text,
                //         email: emailController.text,
                //       );
                //     },
                //   ),
                // );
              }),

              SizedBox(height: 10),

              // **Already have an account? Sign in**
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Already have an account? Sign in",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),

              SizedBox(height: 10),

              // **Divider**
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

  // **TextField builder**
  Widget buildTextField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          suffixIcon: isPassword ? Icon(Icons.visibility) : null,
        ),
      ),
    );
  }

  // **Dropdown builder**
  Widget buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedRole,
        items:
            ["DRIVER", "PASSENGER"].map((role) {
              return DropdownMenuItem(value: role, child: Text(role));
            }).toList(),
        onChanged: (value) {
          setState(() {
            selectedRole = value!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
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
                  children: [
                    //  Text("data"),
                    // Image.asset("assets/google_logo.png", height: 24),
                    SizedBox(width: 10),
                    Text(text),
                  ],
                )
                : Text(text, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
///VirtualBox bilan  windows turib iso liunx urnatsa buladi