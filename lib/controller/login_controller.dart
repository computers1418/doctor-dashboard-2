import 'dart:convert';

import 'package:doctor_dashboard/pages/otp/otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/common_methods.dart';
import '../constants/constants.dart';

class LoginController extends GetxController {
  String username = "";
  String password = "";
  String otpText = "";

  changeUserName(String value) {
    username = value;
    update();
  }

  changePassword(String value) {
    password = value;
    update();
  }

  changeOtp(String value) {
    otpText = value;
    update();
  }

  Future<Map<String, dynamic>> onboardingApi(
      body, BuildContext context, fToast, Function function) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request =
          http.Request('POST', Uri.parse('$baseUrl/api/doctor/onboarding'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 400) {
        showToast(fToast, resp["message"], false);
        function();
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
          function();

          update();
        } else {
          showToast(fToast, resp["message"], true);
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    return resp;
  }

  Future<Map<String, dynamic>> otpValidateApi(
      body, BuildContext context, fToast, Function function) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST', Uri.parse('$baseUrl/api/doctor/onboarding/otp-validate'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 401) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
          function();
          update();
        } else {
          showToast(fToast, resp["message"], true);
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    return resp;
  }

  Future<Map<String, dynamic>> resendOtpApi(
      body, BuildContext context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST', Uri.parse('$baseUrl/api/doctor/onboarding/resend-otp'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 401) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
          update();
        } else {
          showToast(fToast, resp["message"], true);
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    return resp;
  }

  Future<Map<String, dynamic>> changePasswordApi(body,
      BuildContext context, fToast, String password, Function function) async {
    Map<String, dynamic> resp = {};
    print("sdsdsd=====${body}");

    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST', Uri.parse('$baseUrl/api/doctor/onboarding/change-password'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 401) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
          function();
          update();
        } else {
          showToast(fToast, resp["message"], true);
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    return resp;
  }
}
