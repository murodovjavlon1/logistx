import 'package:flutter/material.dart';
import 'package:logistx/providers/visibility_provider.dart';
//import 'package:logistx/screen/auth/presentation/pages/Confirmation_two.dart';
//import 'package:logistx/screen/auth/presentation/pages/confirmation.dart';
import 'package:logistx/screen/auth/view_model/auth_provider.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();
  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final updatePassword = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //  Icon(Icons.arrow_back),
                SizedBox(height: 130),
                Text(
                  "Update Password",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "New password",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill in all the fields";
                    }
                    return null;
                  },
                  controller: newpasswordController,
                  obscureText:
                      context
                          .watch<VisibilityProvider>()
                          .isObscured, // Provider bilan bog‘ladik
                  decoration: InputDecoration(
                    hintText: "Enter new Password",
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
                SizedBox(height: 60),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      updatePassword.update(
                        email: emailController.text,
                        password: newpasswordController.text,
                      );
                      // if (emailController.text.isEmpty ||
                      //     newpasswordController.text.isEmpty) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text("Please fill in all the fields"),
                      //     ),
                      //   );
                      // } else {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return ConfirmationTwo(email: emailController.text, password: newpasswordController.text,

                      //       );
                      //     },
                      //   ),
                      // );
                      // }
                    },
                    child: Text(
                      "Update Password",
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 250, 251, 252),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
