// ignore_for_file: camel_case_types, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:tembok_harapan/screens/tembok_harapan_home.dart';

class AddTembokHarapanPage extends StatefulWidget {
  const AddTembokHarapanPage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/add-harapan';

  @override
  State<AddTembokHarapanPage> createState() => _Tembok_HarapanHomePageState();
}

class _Tembok_HarapanHomePageState extends State<AddTembokHarapanPage> {
  final _formKey = GlobalKey<FormState>();

  String title = "";
  String harapan = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambahkan Harapan'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Harapan',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // https://pub.dev/packages/multi_select_flutter

                // Wrap(
                //   alignment: WrapAlignment.spaceEvenly,
                //   children: _buildButtonsList(_feelingList),
                // ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.account_circle_rounded),
                      hintText: 'Hal apa yang sangat kamu harapkan ?',
                      labelText: 'Harapanmu',
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        title = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        title = value!;
                      });
                    },
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Harapan tidak boleh kosong.'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.sticky_note_2),
                      hintText:
                          'Apa yang akan kamu lakukan agar kamu dapat mewujudkan harapanmu?',
                      labelText: 'Usahamu',
                    ),
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      setState(() {
                        harapan = value!;
                      });
                    },
                    onChanged: (String? value) {
                      setState(() {
                        harapan = value!;
                      });
                    },
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Usahamu tidak boleh kosong.'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextButton(
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF0B36A8)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                            "https://reflekt-io.herokuapp.com/tembok-harapan/add-harapan-flutter",
                            convert.jsonEncode(<String, String>{
                              'title': title,
                              'harapan': harapan,
                            }));
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("Harapan baru telah berhasil disimpan!"),
                          ));
                          Navigator.pushReplacementNamed(
                              context, TembokHarapanHomePage.ROUTE_NAME);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("An error occured, please try again."),
                          ));
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
