import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultText ({
  required String text,
  double size = 35,
  FontWeight fontWeight = FontWeight.bold,
  Color color = Colors.white,
  bool undelLineText=false,
  int ? maxLines,
  TextOverflow? textOverflow,
  double? height,
}){
  return Text(text,
    maxLines: maxLines,
    overflow: textOverflow,

    style: GoogleFonts.aBeeZee(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
      height: height ,
      decoration: undelLineText?TextDecoration.underline:TextDecoration.none,
    )
  );
}
Widget defaultFormFaild({
  required TextEditingController controller,
  required Widget prefixIcon,
  required String hintText,
  bool obscureText= false,
  Widget? suffixIcon,
  String? Function(String?)? validator,
  TextInputType keyboardType = TextInputType.text,
  EdgeInsets? padding,
  Function(String)? onChange,
  int? maxLength,
  Color? fillColor,
  Color? textColor

}){
  return TextFormField(
    onChanged:onChange ,
    cursorHeight: 24,
    validator: validator,
    controller: controller,
    cursorColor: Colors.black,
    keyboardType: keyboardType,
    obscureText: obscureText,
    maxLength: maxLength,
    style: TextStyle(
      color: textColor
    ),
    decoration:  InputDecoration(
      contentPadding: padding,
      fillColor: fillColor,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[700],
          fontWeight: FontWeight.w300
      ),
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10)
      ),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10)
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10)
      ),
    ),


  );
}