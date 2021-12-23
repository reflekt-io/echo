// ignore_for_file: constant_identifier_names

import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:echo/common/network_service.dart';
import 'package:provider/provider.dart';
import 'package:echo/common/background_image.dart';
import 'package:echo/screens/login_screen.dart';
import 'package:flutter/material.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/register';

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}


class _CreateNewAccountState extends State<CreateNewAccount> {
  final _formKey = GlobalKey<FormState>();

  String username = "";
  String email = "";
  String password1 = "";
  String password2 = "";

  Future<http.Response> registFlutter(String username, String email, String password1, String password2) {
  return http.post(
    Uri.parse('http://127.0.0.1:8000/registerflutter'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: convert.jsonEncode(<String, String>{
      'username': username,
      'email': email,
      'password1': password1,
      'password2': password2,
      }),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    final request = context.watch<NetworkService>();
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          const BackgroundImage(image: 'assets/images/login_register_bg.jpg'),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Stack(
                    children: const [
                      Center(
                        child: Text('Register Account',
                            style:
                                TextStyle(fontSize: 60, color: Colors.white)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "contoh: Dummy123",
                            labelText: "Username",
                            labelStyle: const TextStyle(color: Colors.white),
                            icon: const Icon(Icons.people),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              username = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              username = value!;
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "contoh: Dummy@gmail.com",
                            labelText: "Email",
                            labelStyle: const TextStyle(color: Colors.white),
                            icon: const Icon(Icons.attach_email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              email = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              email = value!;
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Masukkan Password",
                            labelText: "Password",
                            labelStyle: const TextStyle(color: Colors.white),
                            icon: const Icon(
                              Icons.lock_outline,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              password1 = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              password1 = value!;
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Konfirmasi Password",
                            labelText: "Konfirmasi Password",
                            labelStyle: const TextStyle(color: Colors.white),
                            icon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              password2 = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              password2 = value!;
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xFF24262A),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Submit to Django server and wait for response
                              registFlutter(username, email, password1, password2);
                              Navigator.pushReplacementNamed(
                                context, LoginScreen.ROUTE_NAME);
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                height: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                                fontSize: 22, color: Colors.white, height: 1.5),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, LoginScreen.ROUTE_NAME);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
