// ignore_for_file: constant_identifier_names
import 'package:provider/provider.dart';
import 'package:echo/common/background_image.dart';
import 'package:echo/screens/create_new_account.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String username = "";
  String password1 = "";
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Stack(
        children: [
        const BackgroundImage(
          image: 'assets/login_register_bg.jpg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,

          body: Column(
            children: [
              const Flexible(
                child: Center(
                  child: Text(
                    'Reflekt.io',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "contoh: Dummy@gmail.com",
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.white),
                        icon: const Icon(Icons.attach_email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                        ),  
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Masukkan Password",
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        icon: const Icon(Icons.lock_outline,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),  
                        ),
                      ),
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
                      onPressed: () {if (_formKey.currentState!.validate()) {}},
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, CreateNewAccount.ROUTE_NAME),
                child: Container(
                  child: const Text(
                    'Create New Account',
                    style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
                  ),
                  decoration: const BoxDecoration(
                    border:
                      Border(bottom: BorderSide(width: 1, color: Colors.white)
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
        )
      ],
      )
    );
  }
}