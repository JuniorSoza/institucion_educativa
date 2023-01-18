import 'package:flutter/material.dart';

class Input {
  static InputDecoration authInput(
      {required String hintTex,
        required String labelText,
        IconData? prefixIcon,
        IconData? suffixIcon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2)),
        hintText: hintTex,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(
          prefixIcon,
          //color: Colors.blue,
        )
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(
          suffixIcon,
          //color: Colors.orangeAccent,
        ): null);
  }
}

class InputForm {
  static InputDecoration formInput(
      {required String hintTex,
        required String labelText,
        IconData? prefixIcon,
        IconData? suffixIcon}) {

    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO( 24, 138, 24,80))),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide( width: 2)),
        hintText: hintTex,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(
          prefixIcon,
          color: Color.fromRGBO( 24, 138, 24,80),
        )
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(
          suffixIcon,
          color: Color.fromRGBO( 24, 138, 24,80),
        ): null);
  }

}