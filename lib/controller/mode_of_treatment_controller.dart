import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/common_methods.dart';
import '../constants/constants.dart';
import '../model/guideline_get_model.dart';
import '../model/treatment_mode_model.dart';

class ModeOfTreatmentController extends GetxController {
  GuidelineGetModel? guidelineGetModel;
  RxBool isDataLoading = false.obs;
  List<String> treatmentModeList = [];

  // List<dynamic> treatmentModeByDoctorIdList = [];
  bool treatment = false;
  String detailsId = "";

  Future<Map<String, dynamic>> getGuideline() async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              '$baseUrl/api/doctor/66a0d21754c2bd0642e7adc4/guideline/get'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 401) {
      } else {
        if (response.statusCode == 200) {
          resp = await CommonMethods.decodeStreamedResponse(response);

          guidelineGetModel = GuidelineGetModel.fromJson(resp['data']);

          update();
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
          guidelineGetModel = GuidelineGetModel(id: "", content: "");
          update();
        }
      }
    } catch (e) {}
    return resp;
  }

  Future<Map<String, dynamic>> addGuideline(
      body, BuildContext context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              '$baseUrl/api/doctor/66a0d21754c2bd0642e7adc4/guideline/add'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 401) {
      } else if (response.statusCode == 400) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["data"], false);

          getGuideline();
        } else {
          showToast(fToast, resp['message']['data'], true);
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    return resp;
  }

  Future<Map<String, dynamic>> deleteGuidelines(
      BuildContext context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              '$baseUrl/api/doctor/66a0d21754c2bd0642e7adc4/guideline/delete'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      print("sdsdsd======${resp}");
      if (response.statusCode == 401) {
      } else if (response.statusCode == 400) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          // CommonMethods.showSnackbar(resp["data"], context);
          showToast(fToast, resp["data"], false);
          getGuideline();
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    return resp;
  }

  Future<Map<String, dynamic>> createTreatmentModes(
      body, BuildContext context) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request =
          http.Request('POST', Uri.parse('$baseUrl/api/treatment-mode/create'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 401) {
      } else {
        if (response.statusCode == 200) {
          resp = await CommonMethods.decodeStreamedResponse(response);
          Data data = Data.fromJson(resp['data']);
          detailsId = data.id;
          update();
          getTreatmentModesByDoctorId(context);
          getTreatmentModes(context);
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    return resp;
  }

  Future<Map<String, dynamic>> updateTreatmentModes(
      body, BuildContext context) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST', Uri.parse('$baseUrl/api/treatment-mode/update/${detailsId}'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 401) {
      } else {
        if (response.statusCode == 200) {
          resp = await CommonMethods.decodeStreamedResponse(response);
          treatment = true;
          getTreatmentModes(context);
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    return resp;
  }

  Future<Map<String, dynamic>> getTreatmentModes(BuildContext context) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'GET', Uri.parse('$baseUrl/api/treatment-mode/details/${detailsId}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 401) {
      } else {
        if (response.statusCode == 200) {
          resp = await CommonMethods.decodeStreamedResponse(response);
          treatmentModeList = List<String>.from(resp['data']['treatmentMode']);
          update();
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    return resp;
  }

  Future<Map<String, dynamic>> getTreatmentModesByDoctorId(
      BuildContext context) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              '$baseUrl/api/treatment-mode/detailsByDoctorId/66a0d21754c2bd0642e7adc4'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 401) {
      } else if (response.statusCode == 400) {
        treatment = false;
      } else {
        if (response.statusCode == 200) {
          resp = await CommonMethods.decodeStreamedResponse(response);

          detailsId = resp["data"]["_id"];

          treatment = true;
          update();
          getTreatmentModes(context);
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    return resp;
  }
}
