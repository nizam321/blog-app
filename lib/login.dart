import 'package:blog/const/button_color.dart';
import 'package:blog/custom/custom_button.dart';
import 'package:blog/custom/custom_widget.dart';
import 'package:blog/firebase_helper/sign_in_auth.dart';
import 'package:blog/firebase_helper/sign_up_auth.dart';
import 'package:blog/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObsecur = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomTextFiedl(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please password";
                    }
                    if (!value.contains('@')) {
                      return 'Invalid';
                    }
                  },
                  controller: _emailController,
                  pIcon: Icons.email_outlined,
                  labeltext: 'E-mail',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  obscureText: _isObsecur,
                  controller: _passController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    hintText: 'Enter password',
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      size: 25,
                      color: Colors.grey,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isObsecur = !_isObsecur;
                        });
                      },
                      child: Icon(_isObsecur == false
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length < 8) {
                      return 'Password is Short';
                    }
                    if (value.length > 10) {
                      return 'Password is Long';
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  var ema = _emailController.text;
                  var pass = _passController.text;
                  SigninData().SignIn(ema, pass, context);
                },
                child: customButton(
                  "Log In",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Wrap(
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deep_orange,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SignUp()),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
