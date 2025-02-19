import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static const String isLogin = "isLogin";
  static const String isMPin = "isMPin";
  static const String isClient = "isClient";
  static const String isLoginId = "isLoginId";
  static const String isToken = "isToken";
  static const String isclientData = "isclientData";

  static setUserName(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString("userName", value);
  }

  static Future getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("userName") ?? "";
  }

  static setOtp(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString("otp", value);
  }

  static Future getOtp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("otp") ?? "";
  }

  static setPassword(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString("password", value);
  }

  static Future getPassword() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("password") ?? "";
  }

  static setDoctorId(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString("doctorId", value);
  }

  static Future getDoctorId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("doctorId") ?? "";
  }

// static Future<bool> logout() async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   return await sharedPreferences.clear();
// }
//
// static Future<bool> setLogin(value) async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   SharedPreferences sharedPreferences =
//       await encryptedSharedPreferences!.getInstance();
//   return await sharedPreferences.setBool(isLogin, value);
// }
//
// static Future getLogin() async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   SharedPreferences sharedPreferences =
//       await encryptedSharedPreferences!.getInstance();
//   return sharedPreferences.getBool(isLogin) ?? true;
// }
//
// static Future setMPin(String value) async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   encryptedSharedPreferences = EncryptedSharedPreferences();
//   return await encryptedSharedPreferences!.setString(isMPin, value);
// }
//
// static Future<String> getMPin() async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   encryptedSharedPreferences = EncryptedSharedPreferences();
//   String mPin = await encryptedSharedPreferences!.getString(isMPin);
//   return mPin;
// }
//
// static Future saveTheme(bool value) async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   SharedPreferences sharedPreferences =
//       await encryptedSharedPreferences!.getInstance();
//   return await sharedPreferences.setBool("theme", value);
// }
//
// static Future getTheme() async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   SharedPreferences sharedPreferences =
//       await encryptedSharedPreferences!.getInstance();
//   return sharedPreferences.getBool("theme");
// }
//
// static Future setClientId(int value) async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   SharedPreferences sharedPreferences =
//       await encryptedSharedPreferences!.getInstance();
//   sharedPreferences.setInt(isClient, value);
// }
//
// static Future<int> getClientId() async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   SharedPreferences sharedPreferences =
//       await encryptedSharedPreferences!.getInstance();
//   return sharedPreferences.getInt(isClient) ?? 0;
// }
//
// static Future setLoginId(int value) async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   SharedPreferences sharedPreferences =
//       await encryptedSharedPreferences!.getInstance();
//   sharedPreferences.setInt(isLoginId, value);
// }
//
// static Future<int> getLoginId() async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   SharedPreferences sharedPreferences =
//       await encryptedSharedPreferences!.getInstance();
//   return sharedPreferences.getInt(isLoginId) ?? 0;
// }
//
// static Future setToken(String value) async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   encryptedSharedPreferences = EncryptedSharedPreferences();
//   encryptedSharedPreferences!.setString(isToken, value);
// }
//
// static Future<String> getToken() async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   encryptedSharedPreferences = EncryptedSharedPreferences();
//   String token = await encryptedSharedPreferences!.getString(isToken);
//   return token;
// }
//
// static Future setClientData(ClientData clientData) async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   encryptedSharedPreferences = EncryptedSharedPreferences();
//   encryptedSharedPreferences!
//       .setString(isclientData, jsonEncode(clientData.toJson()));
// }
//
// static Future<ClientData> getClientData() async {
//   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   encryptedSharedPreferences = EncryptedSharedPreferences();
//   final value = await encryptedSharedPreferences!.getString(isclientData);
//   return ClientData.fromJson(jsonDecode(value));
// }
}
