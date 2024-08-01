import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData? icon;
  final TextInputType textInputType;
  final bool obscureText; // Add this line
  final Widget? suffixIcon; // Add this line

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    this.icon,
    required this.textInputType,
    this.obscureText = false, // Default value
    this.suffixIcon, // Default value
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextField(
        style: const TextStyle(
          color: Color.fromARGB(255, 3, 80, 5),
          fontSize: 20,
          fontFamily: 'RobotoSlab-Bold',
          fontWeight: FontWeight.w600,
        ),
        controller: textEditingController,
        obscureText:
            isPass ? obscureText : false, // Use the obscureText parameter
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color.fromARGB(255, 0, 255, 8)),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 3, 80, 5),
            fontSize: 20,
            fontFamily: 'RobotoSlab-Bold',
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: const Color(0xFFedf0f8),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          suffixIcon: suffixIcon, // Use the suffixIcon parameter
        ),
        keyboardType: textInputType,
      ),
    );
  }
}
