import 'dart:convert';

import 'package:doctor_dashboard/model/schedule_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../constants/common_methods.dart';
import '../constants/constants.dart';

class SetScheduleController extends GetxController {
  List<Datum> schduleList = [];
  List<Datum> previousScheduleList = [];
  List<Datum> savedScheduleList = [];
  List<Map<dynamic, dynamic>> newList = [];
  RxBool isDataLoading = true.obs;

  Future<Map<String, dynamic>> createSchedule(
      body, BuildContext context, fToast, DateTime dateTime) async {
    Map<String, dynamic> resp = {};
    isDataLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST', Uri.parse('$baseUrl/api/doctor/schedule/autoCreate'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 401) {
        showToast(fToast, resp["message"], true);
      } else if (response.statusCode == 400) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
          getScheduleByDate({
            "doctorId": "66bf3adcdd3df57c89074fe1",
            "dateArray": ["${DateFormat("yyyy-MM-dd").format(dateTime)}"]
          }, context);
        } else {
          showToast(fToast, resp["message"]["message"], true);
          isDataLoading.value = false;
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    isDataLoading.value = false;
    return resp;
  }

  addController(Map<dynamic, dynamic> data) {
    newList.add(data);
    update();
  }

  Future<Map<String, dynamic>> createASlot(
      body, BuildContext context, fToast, DateTime dateTime) async {
    Map<String, dynamic> resp = {};
    isDataLoading.value = true;

    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST', Uri.parse('$baseUrl/api/doctor/schedule/create'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);

      if (response.statusCode == 401) {
        isDataLoading.value = false;
        showToast(fToast, resp["error"], true);
      } else if (response.statusCode == 400) {
        isDataLoading.value = false;
        showToast(fToast, resp["error"], true);
      } else if (response.statusCode == 201) {
        isDataLoading.value = false;
        showToast(fToast, resp["message"], false);
      } else {
        if (response.statusCode == 200) {
          isDataLoading.value = false;
          showToast(fToast, resp["message"], false);
          getScheduleByDate({
            "doctorId": "66bf3adcdd3df57c89074fe1",
            "dateArray": ["${DateFormat("yyyy-MM-dd").format(dateTime)}"]
          }, context);
        } else {
          showToast(fToast, resp["error"], true);
          isDataLoading.value = false;
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    isDataLoading.value = false;
    return resp;
  }

  Future<Map<String, dynamic>> deleteSlotOneByOne(
      body, BuildContext context, fToast) async {
    Map<String, dynamic> resp = {};

    isDataLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'DELETE', Uri.parse('$baseUrl/api/doctor/schedule/deleteSlot'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 404) {
        showToast(fToast, resp["message"], false);
      } else if (response.statusCode == 201) {
        showToast(fToast, resp["message"], false);
      } else if (response.statusCode == 400) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
        } else {
          showToast(fToast, resp["message"], true);
          isDataLoading.value = false;
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    isDataLoading.value = false;
    return resp;
  }

  Future<Map<String, dynamic>> copyScheduleForMultipleDay(
      body, BuildContext context, fToast) async {
    Map<String, dynamic> resp = {};

    // isDataLoading.value = true;
    print("sdsdsds=====${body}");
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST', Uri.parse('$baseUrl/api/doctor/schedule/multicopy'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 404) {
        showToast(fToast, resp["message"], false);
      } else if (response.statusCode == 201) {
        showToast(fToast, resp["message"], false);
      } else if (response.statusCode == 400) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
        } else {
          showToast(fToast, resp["message"], true);
          // isDataLoading.value = false;
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    // isDataLoading.value = false;
    return resp;
  }

  Future<Map<String, dynamic>> copyScheduleForToday(
      body, BuildContext context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request =
          http.Request('POST', Uri.parse('$baseUrl/api/doctor/schedule/copy'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 404) {
        showToast(fToast, resp["message"], false);
      } else if (response.statusCode == 201) {
        showToast(fToast, resp["message"], false);
      } else if (response.statusCode == 400) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
        } else {
          showToast(fToast, resp["message"], true);
          // isDataLoading.value = false;
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    // isDataLoading.value = false;
    return resp;
  }

  Future<Map<String, dynamic>> deleteAllSchedule(
      String id, BuildContext context, fToast) async {
    Map<String, dynamic> resp = {};

    isDataLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'DELETE', Uri.parse('$baseUrl/api/doctor/schedule/delete/$id'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 404) {
        showToast(fToast, resp["message"], false);
      } else if (response.statusCode == 201) {
        showToast(fToast, resp["message"], false);
      } else if (response.statusCode == 400) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
        } else {
          showToast(fToast, resp["message"], true);
          isDataLoading.value = false;
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    isDataLoading.value = false;
    return resp;
  }

  Future<Map<String, dynamic>> updateSlotSchedule(
      BuildContext context, fToast, dateTime) async {
    Map<String, dynamic> resp = {};
    isDataLoading.value = true;
    for (int i = 0; i < newList.length; i++) {
      if (newList[i]["edit"] == true) {
        try {
          var headers = {
            'Content-Type': 'application/json',
          };
          var request = http.Request(
              'PUT', Uri.parse('$baseUrl/api/doctor/schedule/update'));

          request.headers.addAll(headers);
          if (doesTimeRangeCrossMidnight(
              "${newList[i]["startController"].text} ${newList[i]["startAm"]}",
              "${newList[i]["endController"].text} ${newList[i]["endAm"]}")) {
            request.body = jsonEncode({
              "doctorId": "66bf3adcdd3df57c89074fe1",
              "newSlot": {
                "slotStartTime":
                    "${DateFormat("yyyy-MM-dd").format(dateTime)} ${newList[i]["startController"].text} ${newList[i]["startAm"]}",
                "slotEndTime":
                    "${DateFormat("yyyy-MM-dd").format(dateTime.add(Duration(days: 1)))} ${newList[i]["endController"].text} ${newList[i]["endAm"]}"
              },
              "oldSlot": {
                "slotStartTime": schduleList.first.slots[i].slotStartTime,
                "slotEndTime": schduleList.first.slots[i].slotEndTime,
              },
              "date": DateFormat("yyyy-MM-dd").format(dateTime)
            });
          } else {
            request.body = jsonEncode({
              "doctorId": "66bf3adcdd3df57c89074fe1",
              "newSlot": {
                "slotStartTime":
                    "${DateFormat("yyyy-MM-dd").format(dateTime)} ${newList[i]["startController"].text} ${newList[i]["startAm"]}",
                "slotEndTime":
                    "${DateFormat("yyyy-MM-dd").format(dateTime)} ${newList[i]["endController"].text} ${newList[i]["endAm"]}"
              },
              "oldSlot": {
                "slotStartTime": schduleList.first.slots[i].slotStartTime,
                "slotEndTime": schduleList.first.slots[i].slotEndTime,
              },
              "date": DateFormat("yyyy-MM-dd").format(dateTime)
            });
          }

          http.StreamedResponse response = await request.send();
          resp = await CommonMethods.decodeStreamedResponse(response);
          if (response.statusCode == 401) {
          } else if (response.statusCode == 400) {
            showToast(fToast, resp["error"], true);
          } else {
            if (response.statusCode == 200) {
              showToast(fToast, resp["message"], false);
            } else {
              showToast(fToast, resp["error"], true);
              isDataLoading.value = false;
              if (kDebugMode) {
                print(response.reasonPhrase);
              }
            }
          }
        } catch (e) {}
      }
    }
    isDataLoading.value = false;
    return resp;
  }

  bool doesTimeRangeCrossMidnight(
      String startTimeString, String endTimeString) {
    DateTime startTime = DateFormat("hh:mm a").parse(startTimeString);
    DateTime endTime = DateFormat("hh:mm a").parse(endTimeString);

    DateTime startDateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, startTime.hour, startTime.minute);
    DateTime endDateTime;

    if (endTime.isBefore(startTime)) {
      endDateTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 1, endTime.hour, endTime.minute);
    } else {
      endDateTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, endTime.hour, endTime.minute);
    }

    return endDateTime.day != startDateTime.day;
  }

  clearnewList() {
    newList.clear();
    // update();
  }

  Future<Map<String, dynamic>> getScheduleByDate(
      body, BuildContext context) async {
    schduleList = [];
    clearnewList();
    isDataLoading.value = true;
    // update();

    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'GET', Uri.parse('$baseUrl/api/doctor/schedule/getByDate'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 401) {
        schduleList = [];
      } else if (response.statusCode == 400) {
        schduleList = [];
      } else {
        if (response.statusCode == 200) {
          resp = await CommonMethods.decodeStreamedResponse(response);

          if (resp["data"] is List) {
            List<dynamic> dataList = resp["data"];
            schduleList = dataList.expand((innerList) {
              return (innerList as List)
                  .map<Datum>((data) => Datum.fromJson(data))
                  .toList();
            }).toList();
            clearnewList();
            for (var element in schduleList.first.slots) {
              newList.add({
                "startAm": element.slotStartTime.split(' ')[2],
                "endAm": element.slotEndTime.split(' ')[2],
                "startTime": element.slotStartTime.split(' ')[1],
                "endTime": element.slotEndTime.split(' ')[1],
                "startController": TextEditingController(
                    text: element.slotStartTime.split(' ')[1]),
                "endController": TextEditingController(
                    text: element.slotEndTime.split(' ')[1]),
                "read": true,
                "new": false,
                "edit": false
              });
            }
          } else {
            schduleList = [];
          }
        } else {
          schduleList = [];
        }
      }
    } catch (e) {}
    isDataLoading.value = false;
    update();
    return resp;
  }

  Future<Map<String, dynamic>> getScheduleById(id, BuildContext context) async {
    schduleList = [];
    clearnewList();
    isDataLoading.value = true;
    // update();

    Map<String, dynamic> resp = {};
    // try {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('GET',
        Uri.parse('$baseUrl/api/doctor/schedule/getById?scheduleId=$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 401) {
      schduleList = [];
    } else if (response.statusCode == 400) {
      schduleList = [];
    } else {
      if (response.statusCode == 201) {
        resp = await CommonMethods.decodeStreamedResponse(response);
        Datum datum = Datum.fromJson(resp["data"]);
        schduleList.add(datum);
        clearnewList();
        for (var element in schduleList.first.slots) {
          newList.add({
            "startAm": element.slotStartTime.split(' ')[2],
            "endAm": element.slotEndTime.split(' ')[2],
            "startTime": element.slotStartTime.split(' ')[1],
            "endTime": element.slotEndTime.split(' ')[1],
            "startController": TextEditingController(
                text: element.slotStartTime.split(' ')[1]),
            "endController":
                TextEditingController(text: element.slotEndTime.split(' ')[1]),
            "read": true,
            "new": false,
            "edit": false
          });
        }
        // } else {
        //   schduleList = [];
        // }
      } else {
        schduleList = [];
      }
    }
    // } catch (e) {}
    isDataLoading.value = false;
    update();
    return resp;
  }

  Future<Map<String, dynamic>> getPreviousScheduleListData(
      body, BuildContext context) async {
    previousScheduleList = [];
    isDataLoading.value = true;
    update();

    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'GET', Uri.parse('$baseUrl/api/doctor/schedule/getByDate'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 401) {
        previousScheduleList = [];
      } else if (response.statusCode == 400) {
        previousScheduleList = [];
      } else {
        if (response.statusCode == 200) {
          resp = await CommonMethods.decodeStreamedResponse(response);

          if (resp["data"] is List) {
            List<dynamic> dataList = resp["data"];
            previousScheduleList = dataList.expand((innerList) {
              return (innerList as List)
                  .map<Datum>((data) => Datum.fromJson(data))
                  .toList();
            }).toList();
          } else {
            previousScheduleList = [];
          }
        } else {
          previousScheduleList = [];
        }
      }
    } catch (e) {}
    isDataLoading.value = false;
    update();
    return resp;
  }

  Future<Map<String, dynamic>> getSavedScheduleList(
      body, BuildContext context) async {
    // savedScheduleList = [];
    isDataLoading.value = true;
    // update();

    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'GET', Uri.parse('$baseUrl/api/doctor/schedule/getByDate'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 401) {
        savedScheduleList = [];
      } else if (response.statusCode == 400) {
        savedScheduleList = [];
      } else {
        if (response.statusCode == 200) {
          resp = await CommonMethods.decodeStreamedResponse(response);

          if (resp["data"] is List) {
            List<dynamic> dataList = resp["data"];
            savedScheduleList = dataList.expand((innerList) {
              return (innerList as List)
                  .map<Datum>((data) => Datum.fromJson(data))
                  .toList();
            }).toList();
            // update();
            print("sdsdsds====${savedScheduleList[9].slots[1].slotStartTime}");
          } else {
            savedScheduleList = [];
          }
        } else {
          savedScheduleList = [];
        }
      }
    } catch (e) {}
    isDataLoading.value = false;
    update();
    return resp;
  }

  void updateReadStatus(Map<dynamic, dynamic> element) {
    for (int i = 0; i < newList.length; i++) {
      if (element == newList[i]) {
        newList[i]["read"] = false;
        newList[i]["edit"] = true;
      } else {
        newList[i]["read"] = true;
        newList[i]["edit"] = false;
      }
    }
    update();
  }

  void updateAllReadStatus() {
    for (int i = 0; i < newList.length; i++) {
      newList[i]["read"] = true;
      newList[i]["edit"] = false;
    }
    update();
  }

  void updateStartAMPM(dynamic element, index) {
    // print("sdsd====${element}");
    if (element == null) {
      if (newList[index]["startAm"] == "AM") {
        newList[index]["startAm"] = "PM";
      } else {
        newList[index]["startAm"] = "AM";
      }
    } else {
      for (int i = 0; i < newList.length; i++) {
        if (element == newList[i]) {
          if (newList[i]["startAm"] == "AM") {
            newList[i]["startAm"] = "PM";
          } else {
            newList[i]["startAm"] = "AM";
          }
        }
      }
    }

    update();
  }

  void updateEndAMPM(dynamic element, index) {
    if (element == null) {
      if (newList[index]["endAm"] == "AM") {
        newList[index]["endAm"] = "PM";
      } else {
        newList[index]["endAm"] = "AM";
      }
    } else {
      for (int i = 0; i < newList.length; i++) {
        if (element == newList[i]) {
          if (newList[i]["endAm"] == "AM") {
            newList[i]["endAm"] = "PM";
          } else {
            newList[i]["endAm"] = "AM";
          }
        }
      }
    }

    update();
  }

  startControllerChange(String value, int index) {
    if (value.length == 3 && value[2] == ':') {
      newList[index]["startController"].text =
          newList[index]["startController"].text.substring(0, 2);
      newList[index]["startController"].selection = TextSelection.fromPosition(
          TextPosition(offset: newList[index]["startController"].text.length));
    } else if (value.length == 3) {
      String char = newList[index]["startController"].text[2];
      newList[index]["startController"].text =
          newList[index]["startController"].text.substring(0, 2);
      newList[index]["startController"].text += ':$char';
      newList[index]["startController"].selection = TextSelection.fromPosition(
          TextPosition(offset: newList[index]["startController"].text.length));
    } else if (value.length == 5) {
      FocusManager.instance.primaryFocus?.unfocus();
    } else if (value.length > 5) {
      newList[index]["startController"].text =
          newList[index]["startController"].text.substring(0, 5);
      newList[index]["startController"].selection = TextSelection.fromPosition(
          TextPosition(offset: newList[index]["startController"].text.length));
    }
  }

  endControllerChange(String value, int index) {
    if (value.length == 3 && value[2] == ':') {
      newList[index]["endController"].text =
          newList[index]["endController"].text.substring(0, 2);
      newList[index]["endController"].selection = TextSelection.fromPosition(
          TextPosition(offset: newList[index]["endController"].text.length));
    } else if (value.length == 3) {
      String char = newList[index]["endController"].text[2];
      newList[index]["endController"].text =
          newList[index]["endController"].text.substring(0, 2);
      newList[index]["endController"].text += ':$char';
      newList[index]["endController"].selection = TextSelection.fromPosition(
          TextPosition(offset: newList[index]["endController"].text.length));
    } else if (value.length == 5) {
      FocusManager.instance.primaryFocus?.unfocus();
    } else if (value.length > 5) {
      newList[index]["endController"].text =
          newList[index]["endController"].text.substring(0, 5);
      newList[index]["endController"].selection = TextSelection.fromPosition(
          TextPosition(offset: newList[index]["endController"].text.length));
    }
  }
}
