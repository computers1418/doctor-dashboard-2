import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommonMethods {

  static Map decodeResponse(String response) {
    Map respJson = {};
    try {
      respJson = jsonDecode(response);
      return respJson;
    } catch (e) {
      respJson = {};
      return respJson;
    }
  }

  static Future<Map<String, dynamic>> decodeStreamedResponse(
      http.StreamedResponse response) async {
    Map<String, dynamic> respJson = {};
    try {
      respJson = jsonDecode(await response.stream.bytesToString());
      return respJson;
    } catch (e) {
      respJson = {};
      return respJson;
    }
  }
}

class MapAppOption {
  final String name;
  final String package;

  MapAppOption(this.name, this.package);
}
