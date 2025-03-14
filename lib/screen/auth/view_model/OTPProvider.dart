import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:logistx/router/service/network_service.dart';

class OTPProvider extends ChangeNotifier {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  Timer? _timer;
  int _remainingTime = 30; // OTP 30 soniya davomida yaroqli

  // Getterlar qo'shildi
  List<TextEditingController> get controllers => _controllers;
  List<FocusNode> get focusNodes => _focusNodes;
  int get remainingTime => _remainingTime;

  OTPProvider() {
    _startTimer();
  }
  void restartTimer() {
    _clearOTP();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _remainingTime = 30;
    notifyListeners();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        _clearOTP(); // Faqat OTP ni tozalaymiz, yangi timer boshlamaymiz
        _timer?.cancel();
      }
    });
  }

  void onOtpChanged(int index, String value, BuildContext context) {
    if (value.isNotEmpty) {
      if (index < 5) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
      }
    } else if (index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
    notifyListeners();
  }

  void _clearOTP() {
    for (var controller in _controllers) {
      controller.clear();
    }
    notifyListeners();
  }

  String getOtp() {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
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
      debugPrint("${response}");
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

void main() async {
  String? deviceId = await getDeviceId();
  print("Device ID: $deviceId");
}

 Future<void> newPassword({
    required String email,
    required String password,
    required String code,
  }) async {
    final response = await ClientService.post(
      api: ClientService.checkUpdated,
      param: {"email": email, "password": password, "code": code},
    );
    if (response != null) {
      // ignore: unused_local_variable
      final date = jsonDecode(response);
    }
  }

}
