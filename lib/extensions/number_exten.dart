import 'package:flutter/material.dart';

extension NumberExtensions on int {

  h() => SizedBox(height: toDouble());
  w() => SizedBox(width: toDouble());
}