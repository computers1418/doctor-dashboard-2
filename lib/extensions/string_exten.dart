import 'package:flutter/material.dart';

extension TextExtension on String {
  regular10({Color? color}) => Text(this,
      style: TextStyle(
          fontFamily: 'Slussen',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color ?? Colors.white));

  regular14({Color? color}) => Text(this,
      style: TextStyle(
          fontFamily: 'Slussen',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color ?? Colors.white));

  bold14({Color? color}) => Text(this,
      style: TextStyle(
          fontFamily: 'Slussen',
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: color ?? Colors.white));

  bold16({Color? color}) => Text(this,
      style: TextStyle(
          fontFamily: 'Slussen',
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: color ?? Colors.white));

  bold24({Color? color}) => Text(this,
      style: TextStyle(
          fontFamily: 'Slussen',
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: color ?? Colors.white));

  bold12({Color? color}) => Text(this,
      style: TextStyle(
          fontFamily: 'Slussen',
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: color ?? Colors.white));

  semibold12({Color? color}) => Text(this,
      style: TextStyle(
          fontFamily: 'Slussen',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color ?? Colors.white));

  semibold20({Color? color}) => Text(this,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Slussen',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: color ?? Colors.white));

  medium14({Color? color}) => Text(this,
      style: TextStyle(
          fontFamily: 'Slussen',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color ?? Colors.white));

  extraLight14({Color? color}) => Text(this,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Slussen',
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: color ?? Colors.white));
}
