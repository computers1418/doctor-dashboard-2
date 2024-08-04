import 'package:flutter/material.dart';

class InputField2 extends StatelessWidget {
  final String hintText;
  final ValueChanged onChanged;
  final TextEditingController controller;
  const InputField2({super.key, required this.hintText, required this.onChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        onChanged: (e)=> onChanged(e),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
            hintText: hintText,
            fillColor: Colors.white,
            hintStyle: const TextStyle(
                fontFamily: 'Slussen',
                fontWeight: FontWeight.w500,
                color: Color(0x4D201A3F),
                fontSize: 14
            ),
            focusedBorder: OutlineInputBorder(

                borderSide: const BorderSide(
                    width: 0,
                    color: Colors.white
                ),
                borderRadius: BorderRadius.circular(25)
            ),
            enabledBorder: OutlineInputBorder(

                borderSide: const BorderSide(
                    width: 0,
                    color: Colors.white
                ),
                borderRadius: BorderRadius.circular(25)
            ),
            border: OutlineInputBorder(

                borderSide: const BorderSide(
                    width: 0,
                    color: Colors.white
                ),
                borderRadius: BorderRadius.circular(25)
            )
        ),
        style: const TextStyle(
            fontFamily: 'Slussen',
            fontWeight: FontWeight.w800,
            color: Color(0xFF201A3F),
            fontSize: 14
        )
    );
  }
}