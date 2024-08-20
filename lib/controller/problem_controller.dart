import 'dart:convert';

import 'package:doctor_dashboard/model/medicine_model.dart';
import 'package:doctor_dashboard/model/surgery_model.dart';
import 'package:doctor_dashboard/model/test_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/common_methods.dart';
import '../constants/constants.dart';
import '../model/set_problem_model.dart';

class ProblemController extends GetxController {
  // List<SetProblemModel> problemList = [];
  List<Map<dynamic, dynamic>> newProblemList = [];
  List<Map<dynamic, dynamic>> newTestList = [];
  List<Map<dynamic, dynamic>> newMedicineList = [];
  List<Map<dynamic, dynamic>> newSurgeryList = [];
  var isFetching = false.obs;

  addController(Map<dynamic, dynamic> data) {
    newProblemList.add(data);
    update();
  }

  addTestController(Map<dynamic, dynamic> data) {
    newTestList.add(data);
    update();
  }

  addMedicineController(Map<dynamic, dynamic> data) {
    newMedicineList.add(data);
    update();
  }

  addSurgeryController(Map<dynamic, dynamic> data) {
    newSurgeryList.add(data);
    update();
  }

  Future<Map<String, dynamic>> getAllSetProblemList(body) async {
    isFetching.value = true;
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request =
          http.Request('POST', Uri.parse('$baseUrl/api/doctor/problem/list'));

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        resp = await CommonMethods.decodeStreamedResponse(response);

        if (resp["data"] != null) {
          clearNewProblemList();
          List<dynamic> dataList = resp["data"];

          // Assuming you have a SetProblemModel with a fromJson method
          List<SetProblemModel> problemList = dataList
              .map((element) => SetProblemModel.fromJson(element))
              .toList();
          for (var element in problemList) {
            newProblemList.add({
              "id": element.id,
              "problemController": TextEditingController(
                text: element.problemName,
              ),
              "problemPrice": TextEditingController(text: element.price),
              "read": true,
              "new": false,
              "edit": false
            });
          }
        } else {
          // problemList = [];
        }
      } else {
        // problemList = [];
      }
    } catch (e) {}
    isFetching.value = false;
    update();

    return resp;
  }

  Future<Map<String, dynamic>> getAllTestList(body) async {
    isFetching.value = true;
    // problemList = [];
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request =
          http.Request('POST', Uri.parse('$baseUrl/api/doctor/test/list'));

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        resp = await CommonMethods.decodeStreamedResponse(response);

        if (resp["data"] != null) {
          clearTestList();
          List<dynamic> dataList = resp["data"];

          // Assuming you have a SetProblemModel with a fromJson method
          List<TestModel> problemList =
              dataList.map((element) => TestModel.fromJson(element)).toList();
          for (var element in problemList) {
            newTestList.add({
              "id": element.id,
              "problemController": TextEditingController(
                text: element.testName,
              ),
              "problemPrice": TextEditingController(text: element.price),
              "read": true,
              "new": false,
              "edit": false
            });
          }
        } else {
          // problemList = [];
        }
      } else {
        // problemList = [];
      }
    } catch (e) {}
    isFetching.value = false;
    update();

    return resp;
  }

  Future<Map<String, dynamic>> getAllMedicineList(body) async {
    isFetching.value = true;
    // problemList = [];
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request =
          http.Request('POST', Uri.parse('$baseUrl/api/doctor/medicine/list'));

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        resp = await CommonMethods.decodeStreamedResponse(response);

        if (resp["data"] != null) {
          clearTestList();
          List<dynamic> dataList = resp["data"];

          // Assuming you have a SetProblemModel with a fromJson method
          List<MedicineModel> problemList = dataList
              .map((element) => MedicineModel.fromJson(element))
              .toList();
          for (var element in problemList) {
            newMedicineList.add({
              "id": element.id,
              "problemController": TextEditingController(
                text: element.medicineName,
              ),
              "problemPrice": TextEditingController(text: element.price),
              "read": true,
              "new": false,
              "edit": false
            });
          }
        } else {
          // problemList = [];
        }
      } else {
        // problemList = [];
      }
    } catch (e) {}
    isFetching.value = false;
    update();

    return resp;
  }

  Future<Map<String, dynamic>> getAllSurgeryList(body) async {
    isFetching.value = true;
    // problemList = [];
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request =
          http.Request('POST', Uri.parse('$baseUrl/api/doctor/surgery/list'));

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        resp = await CommonMethods.decodeStreamedResponse(response);

        if (resp["data"] != null) {
          clearTestList();
          List<dynamic> dataList = resp["data"];

          // Assuming you have a SetProblemModel with a fromJson method
          List<SurgeryModel> problemList = dataList
              .map((element) => SurgeryModel.fromJson(element))
              .toList();
          for (var element in problemList) {
            newSurgeryList.add({
              "id": element.id,
              "problemController": TextEditingController(
                text: element.surgeryName,
              ),
              "problemPrice": TextEditingController(text: element.price),
              "read": true,
              "new": false,
              "edit": false
            });
          }
        } else {
          // problemList = [];
        }
      } else {
        // problemList = [];
      }
    } catch (e) {}
    isFetching.value = false;
    update();

    return resp;
  }

  void updateReadStatus(Map<dynamic, dynamic> element) {
    for (int i = 0; i < newProblemList.length; i++) {
      if (element == newProblemList[i]) {
        newProblemList[i]["read"] = false;
        newProblemList[i]["edit"] = true;
      } else {
        newProblemList[i]["read"] = true;
        newProblemList[i]["edit"] = false;
      }
    }
    update();
  }

  void updateTestReadStatus(Map<dynamic, dynamic> element) {
    for (int i = 0; i < newTestList.length; i++) {
      if (element == newTestList[i]) {
        newTestList[i]["read"] = false;
        newTestList[i]["edit"] = true;
      } else {
        newTestList[i]["read"] = true;
        newTestList[i]["edit"] = false;
      }
    }
    update();
  }

  void updateMedicineReadStatus(Map<dynamic, dynamic> element) {
    for (int i = 0; i < newMedicineList.length; i++) {
      if (element == newMedicineList[i]) {
        newMedicineList[i]["read"] = false;
        newMedicineList[i]["edit"] = true;
      } else {
        newMedicineList[i]["read"] = true;
        newMedicineList[i]["edit"] = false;
      }
    }
    update();
  }

  void updateSurgeryReadStatus(Map<dynamic, dynamic> element) {
    for (int i = 0; i < newSurgeryList.length; i++) {
      if (element == newSurgeryList[i]) {
        newSurgeryList[i]["read"] = false;
        newSurgeryList[i]["edit"] = true;
      } else {
        newSurgeryList[i]["read"] = true;
        newSurgeryList[i]["edit"] = false;
      }
    }
    update();
  }

  void updateAllReadStatus() {
    for (int i = 0; i < newProblemList.length; i++) {
      newProblemList[i]["read"] = true;
      newProblemList[i]["edit"] = false;
    }
    update();
  }

  void updateTestAllReadStatus() {
    for (int i = 0; i < newTestList.length; i++) {
      newProblemList[i]["read"] = true;
      newProblemList[i]["edit"] = false;
    }
    update();
  }

  void updateMedicineAllReadStatus() {
    for (int i = 0; i < newMedicineList.length; i++) {
      newMedicineList[i]["read"] = true;
      newMedicineList[i]["edit"] = false;
    }
    update();
  }

  void updateSurgeryAllReadStatus() {
    for (int i = 0; i < newSurgeryList.length; i++) {
      newSurgeryList[i]["read"] = true;
      newSurgeryList[i]["edit"] = false;
    }
    update();
  }

  clearNewProblemList() {
    newProblemList.clear();
  }

  clearTestList() {
    newTestList.clear();
  }

  clearMedicineList() {
    newMedicineList.clear();
  }

  clearSurgeryList() {
    newSurgeryList.clear();
  }

  Future<Map<String, dynamic>> setProblem(body, context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var request =
          http.Request('POST', Uri.parse('$baseUrl/api/doctor/problem/add'));

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
          // getListInvitation();
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

  Future<Map<String, dynamic>> setTest(body, context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var request =
          http.Request('POST', Uri.parse('$baseUrl/api/doctor/test/add'));

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
          // getListInvitation();
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

  Future<Map<String, dynamic>> setMedicine(body, context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var request =
          http.Request('POST', Uri.parse('$baseUrl/api/doctor/medicine/add'));

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
          // getListInvitation();
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

  Future<Map<String, dynamic>> setSurgery(body, context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var request =
          http.Request('POST', Uri.parse('$baseUrl/api/doctor/surgery/add'));

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
          // getListInvitation();
          // getAllSurgeryList({"doctorId": "66bf3adcdd3df57c89074fe1"});
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

  Future<Map<String, dynamic>> updateProblem(
      context, fToast, body, endpoint, id, VoidCallback action) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var request = http.Request(
          'PUT', Uri.parse('$baseUrl/api/doctor/${endpoint}/${id}'));

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

          action();
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

  Future<Map<String, dynamic>> deleteProblem(
      id, context, fToast, endpoint, VoidCallback action) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var request = http.Request(
          'DELETE', Uri.parse('$baseUrl/api/doctor/${endpoint}/$id'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 401) {
      } else if (response.statusCode == 403) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
          // getAllSetProblemList(
          //     {"doctorId": "66bf3adcdd3df57c89074fe1", "isDoctor": "yes"});
          action();
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
