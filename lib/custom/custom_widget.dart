import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextFiedl extends StatelessWidget {
  CustomTextFiedl({
    super.key,
    this.controller,
    this.validator,
    this.hintext,
    this.pIcon,
    this.sIcon,
    this.labeltext,
  });

  TextEditingController? controller;
  dynamic? validator, obscureText;
  String? hintext, labeltext;
  IconData? pIcon, sIcon, button;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        // validator: validator,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
          prefixIcon: Icon(pIcon),
          suffixIcon: Icon(sIcon),
          labelText: labeltext,
        ),
      ),
    );
  }
}
