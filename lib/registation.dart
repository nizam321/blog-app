import 'package:blog/custom/custom_button.dart';
import 'package:blog/custom/custom_widget.dart';
import 'package:blog/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Registation extends StatefulWidget {
  const Registation({super.key});

  @override
  State<Registation> createState() => _RegistationState();
}

class _RegistationState extends State<Registation> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _birthController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  List<String> genderList = ["Male", "Female", "Other"];

  Future<void> _selectDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _birthController.text =
            "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  addUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference userData =
        FirebaseFirestore.instance.collection('user-details');
    return userData
        .doc(currentUser!.email)
        .set({
          'Name': _nameController.text,
          'Email': _emailController.text,
          'Country': _countryController.text,
          'Birth': _birthController.text,
          'Gender': _genderController.text,
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen())))
        .catchError((error) => print("something is wrong. $error"));
  }

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
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full name',
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: _countryController,
                  decoration: InputDecoration(
                    labelText: 'Country',
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: _birthController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    labelText: "date of birth",
                    suffixIcon: IconButton(
                      onPressed: () => _selectDatePicker(context),
                      icon: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: _genderController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    labelText: "Gender",
                    suffixIcon: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        items: genderList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                            onTap: () {
                              setState(() {
                                _genderController.text = value;
                              });
                            },
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  addUser();
                },
                child: customButton('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
