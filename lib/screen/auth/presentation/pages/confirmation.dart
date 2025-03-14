//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logistx/screen/auth/view_model/OTPProvider.dart';
import 'package:provider/provider.dart';

class Confirmation extends StatelessWidget {
  final String password;
  final String userName;
  final String email;
  Confirmation({
    super.key,
    required this.email,
    required this.password,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final veriya = Provider.of<OTPProvider>(context, );
     final otpProvider = Provider.of<OTPProvider>(context,listen: false );
    // final authProvi = Provider.of<FirebaseAuth>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Please confirm your email!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Enter verification code:",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 50),
            _buildOTPFields(context),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "We sent a code to your email",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "$email",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 30),
            _buildTimerAnimation(context),
            SizedBox(height: 5),
          //  _buildSubmitButton(context),

            SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () async {
          String? deviceId = await veriya.getDeviceId();
          String otpCode = otpProvider.getOtp();
          
          veriya.veriy(
            email: email,
            password: password,
            deviseId: deviceId!,
            id: 123,
            userName: userName,
            code:otpCode ,
          );
        },
        child: Text(
          "Tasdiqlash",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    )
          ],
        ),
      ),
    );
  }

  Widget _buildTimerAnimation(BuildContext context) {
    return Consumer<OTPProvider>(
      builder: (context, otpProvider, child) {
        if (otpProvider.remainingTime == 0) {
          return TextButton(
            onPressed: () {
              otpProvider.restartTimer(); // Timer qayta boshlanadi
            },
            child: Text(
              "Qayta yuborish",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          );
        }

        return Text(
          "Qolgan vaqt: ${otpProvider.remainingTime} soniya",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        );
      },
    );
  }

  Widget _buildOTPFields(BuildContext context) {
    final otpProvider = Provider.of<OTPProvider>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 45,
          child: TextField(
            controller: otpProvider.controllers[index],
            focusNode: otpProvider.focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged:
                (value) => otpProvider.onOtpChanged(index, value, context),
            decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      }),
    );
  }

  
}
