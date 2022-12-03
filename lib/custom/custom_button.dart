import 'package:blog/const/button_color.dart';
import 'package:flutter/material.dart';

Widget customButton(buttonText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      decoration: BoxDecoration(
          color: AppColors.deep_orange, borderRadius: BorderRadius.circular(5)),
      height: 50,
      width: double.infinity,
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
