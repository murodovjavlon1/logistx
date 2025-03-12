  import 'package:shared_preferences/shared_preferences.dart';

enum StorageKey {
  lang,
  deviceId,
  user,
  image,
  token,
  refreshToken,
  userType,
}

sealed class UserStorage {

  static Future<void> store({required StorageKey key, required String value}) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString(key.name, value);
  }

  static Future<String?> load({required StorageKey key}) async {
    final storage = await SharedPreferences.getInstance();
    final result = storage.getString(key.name);
    if(result == null){
      return null;
    }else{
      return result;
    }
}

  static Future<void> delete({required StorageKey key}) async {
    final storage = await SharedPreferences.getInstance();
    await storage.remove(key.name);
  }
}
