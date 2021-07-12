import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase/screens/Login.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  late Map<String, Object> data;

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController password1Controller = new TextEditingController();
  TextEditingController password2Controller = new TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.reference().child("users");

  bool isSuccess = false;

  String encrypt(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  createUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: password1Controller.text);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account Created Successfully, Login Now')));
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => new Login()));
      storeData();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for this email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('The account already exists for this email.')));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  storeData() {
    try {
      ref.push().set(data);
      print('Stored Data');
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, left: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    size: 35,
                    color: Colors.blue,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 25),
                    child: Text(
                      'Let\'s Get Started!',
                      style: TextStyle(
                          fontSize: 28.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(0),
                    alignment: Alignment.center,
                    child: Text(
                      'Create an account to continue',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                        color: Colors.black38,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    //--------------------------------------Username-----------------------------------------------------
                    Container(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        cursorColor: Colors.black38,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          hintText: "Username",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 19,
                          ),
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: Colors.blue,
                          ),
                          focusColor: Colors.black38,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //--------------------------------------Username-----------------------------------------------------
                    Container(
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        cursorColor: Colors.black38,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          hintText: "Email",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 19,
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          focusColor: Colors.black38,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //--------------------------------------Username-----------------------------------------------------
                    Container(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: mobileController,
                        cursorColor: Colors.black38,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          hintText: "Mobile Number",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 19,
                          ),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.blue,
                          ),
                          focusColor: Colors.black38,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //--------------------------------------Username-----------------------------------------------------
                    Container(
                      child: TextField(
                        controller: password1Controller,
                        cursorColor: Colors.black38,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 19,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: TextField(
                        controller: password2Controller,
                        cursorColor: Colors.black38,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 19,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                        ),
                        obscureText: true,
                      ),
                    ),

                    SizedBox(height: 20.0),
                    Container(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (password1Controller.text ==
                              password2Controller.text) {
                            data = {
                              "username": nameController.text,
                              "email": emailController.text,
                              "phone_no": mobileController.text,
                              "password": encrypt(password1Controller.text),
                            };
                            createUser(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Enter Correct Details')));
                          }
                        },
                        child: Text(
                          'CREATE',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: EdgeInsets.all(0.0),
                          primary: Colors.blue, // <-- Button color
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new Login()));
                              },
                              child: Text(
                                'Login Here',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
