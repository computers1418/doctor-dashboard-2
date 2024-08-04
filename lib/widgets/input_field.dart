import 'package:flutter/material.dart';

import '../constants/colors_const.dart';

class InputField extends StatelessWidget {
  final String image;
  final String hintText;
  final ValueChanged onChanged;
  final TextEditingController controller;
  const InputField({super.key, required this.image, required this.hintText, required this.onChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (e)=> onChanged(e),
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
        prefixIcon: Container(
          width: 48, height: 34,
          margin: const EdgeInsets.only(left: 10),
          padding: const EdgeInsets.all(12),
          child: ImageIcon(AssetImage(image), color: ColorsConst.secondary, ),
        ),
        hintText: hintText,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          fontFamily: 'Slussen',
          fontWeight: FontWeight.w500,
          color: Color(0x4D201A3F),
          fontSize: 12
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25)
        )
      ),
      style: const TextStyle(
        fontFamily: 'Slussen',
        fontWeight: FontWeight.w800,
        color: Color(0xFF201A3F),
        fontSize: 12
      )
    );
  }
}