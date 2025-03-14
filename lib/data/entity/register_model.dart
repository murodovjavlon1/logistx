class RegisterModel {
  String email;
  String username;
  String password;
  String fullName;
  String deviceId;
  String role;

  RegisterModel({
    required this.email,
    required this.username,
    required this.password,
    required this.fullName,
    required this.deviceId,
    required this.role,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    email: json["email"],
    username: json["username"],
    password: json["password"],
    fullName: json["fullName"],
    deviceId: json["deviceId"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "username": username,
    "password": password,
    "fullName": fullName,
    "deviceId": deviceId,
    "role": role,
  };
}
