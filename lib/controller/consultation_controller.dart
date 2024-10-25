import 'dart:convert';

import 'package:doctor_dashboard/model/phone_email_consult_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/common_methods.dart';
import '../constants/constants.dart';

class ConsultationController extends GetxController {
  List<String> selectProblem = [];
  List<String> selectTest = [];
  List<String> selectSurgery = [];
  List<String> selectMedicine = [];
  List<PhoneEmailConsultModel> getEmailPhoneConsultList = [];
  List<PhoneEmailConsultModel> historyByPatientIdList = [];
  List<PhoneEmailConsultModel> historyByDoctorIdList = [];
  List<PhoneEmailConsultModel> historyByYesterday = [];
  List<PhoneEmailConsultModel> historyByUpcoming = [];
  var isFetching = false;
  var historyIsFetching = false;
  var historyDoctorIdIsFetching = false;

  addProblem(List<String> list) {
    selectProblem = [];
    selectProblem.addAll(list);
    // update();
  }

  addTest(List<String> list) {
    selectTest = [];
    selectTest.addAll(list);
    // update();
  }

  addSurgery(List<String> list) {
    selectSurgery = [];
    selectSurgery.addAll(list);
    // update();
  }

  addMedicine(List<String> list) {
    selectMedicine = [];
    selectMedicine.addAll(list);
    // update();
  }

  clearData() {
    selectMedicine.clear();
    selectSurgery.clear();
    selectTest.clear();
    selectProblem.clear();
    update();
  }

  Future<Map<String, dynamic>> getByPhoneEmail(body) async {
    getEmailPhoneConsultList = [];
    isFetching = true;
    update();
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST', Uri.parse('$baseUrl/api/user/consultation/byPhoneOrEmail'));

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        resp = await CommonMethods.decodeStreamedResponse(response);

        if (resp["data"] != null) {
          // List<dynamic> dataList = resp["data"];
          getEmailPhoneConsultList
              .add(PhoneEmailConsultModel.fromJson(resp["data"]));
        } else {
          // problemList = [];
        }
      } else {
        // problemList = [];
      }
    } catch (e) {}
    isFetching = false;
    update();

    return resp;
  }

  Future<Map<String, dynamic>> getHistoryByPatientId(body) async {
    historyByPatientIdList = [];
    historyIsFetching = true;
    update();
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request('POST',
          Uri.parse('$baseUrl/api/user/consultation/historyByPatientId'));

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        resp = await CommonMethods.decodeStreamedResponse(response);

        if (resp["data"] != null) {
          List<dynamic> dataList = resp["data"];
          historyByPatientIdList = dataList
              .map((element) => PhoneEmailConsultModel.fromJson(element))
              .toList();
        } else {
          // problemList = [];
        }
      } else {
        // problemList = [];
      }
    } catch (e) {}
    historyIsFetching = false;
    update();

    return resp;
  }

  Future<Map<String, dynamic>> getHistoryByDoctorId(body) async {
    historyByDoctorIdList = [];
    historyDoctorIdIsFetching = true;
    update();
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request('POST',
          Uri.parse('$baseUrl/api/user/consultation/historyByDoctorId'));

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        resp = await CommonMethods.decodeStreamedResponse(response);

        if (resp["data"] != null) {
          List<dynamic> dataList = resp["data"];
          historyByDoctorIdList = dataList
              .map((element) => PhoneEmailConsultModel.fromJson(element))
              .toList();
        } else {
          // problemList = [];
        }
      } else {
        // problemList = [];
      }
    } catch (e) {}
    historyDoctorIdIsFetching = false;
    update();

    return resp;
  }

  Future<Map<String, dynamic>> getHistoryAppointment(body) async {
    historyByYesterday = [];
    historyByUpcoming = [];
    update();
    Map<String, dynamic> resp = {};
    // try {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST', Uri.parse('$baseUrl/api/user/consultation/historyByDoctorId'));

    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    http.StreamedResponse response = await request.send();
    resp = await CommonMethods.decodeStreamedResponse(response);
    if (response.statusCode == 200) {
      DateTime now = DateTime.now();
      DateTime yesterday = now.subtract(Duration(days: 1));

      if (resp["data"] != null) {
        List<dynamic> dataList = resp["data"];
        historyByYesterday = dataList
            .map((element) => PhoneEmailConsultModel.fromJson(element))
            .where(
          (element) {
            return element.dateTime == yesterday;
          },
        ).toList();
        historyByUpcoming = dataList
            .map((element) => PhoneEmailConsultModel.fromJson(element))
            .where(
          (element) {
            return element.dateTime != yesterday;
          },
        ).toList();
      } else {
        // problemList = [];
      }
    } else {
      // problemList = [];
    }
    // } catch (e) {}
    update();

    return resp;
  }

  Future<Map<String, dynamic>> createConsult(
      body, context, fToast, Function(Map<String, dynamic>) callback) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var request = http.Request(
          'POST', Uri.parse('$baseUrl/api/user/consultation/createconsult'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 401) {
      } else if (response.statusCode == 403) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
          callback(resp["data"]);
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

  Future<Map<String, dynamic>> updatebyDoc(body, context, fToast,
      Function(Map<String, dynamic>) callback, id) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var request = http.Request(
          'PUT', Uri.parse('$baseUrl/api/user/consultation/updatebyDoc/$id'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      print("sdsdsdsd=====${id}");
      if (response.statusCode == 401) {
      } else if (response.statusCode == 403) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);

          callback(resp["data"]);
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

  Future<Map<String, dynamic>> otpVerification(body, context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var request = http.Request(
          'PUT', Uri.parse('$baseUrl/api/user/consultation/otpverification'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 401) {
      } else if (response.statusCode == 403) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
          Navigator.pop(context);
          Navigator.pop(context);
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
