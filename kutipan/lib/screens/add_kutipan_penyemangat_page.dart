// ignore_for_file: camel_case_types, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:kutipan/screens/kutipan_penyemangat_home.dart';

class AddKutipanPenyemangatPage extends StatefulWidget {
  const AddKutipanPenyemangatPage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/add-kutipan';

  @override
  State<AddKutipanPenyemangatPage> createState() =>
      _Kutipan_PenyemangatHomePageState();
}

class _Kutipan_PenyemangatHomePageState
    extends State<AddKutipanPenyemangatPage> {
  final _formKey = GlobalKey<FormState>();
  String nama = "";
  String kutipan = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambahkan Kutipan'),
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
                    'Kutipan Penyemangat',
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
                      hintText: 'Masukin nama kamu (boleh anonim juga :D)',
                      labelText: 'Nama',
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        nama = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        nama = value!;
                      });
                    },
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Nama tidak boleh kosong.'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.sticky_note_2),
                      hintText: 'Yuk, tambahin lagi kutipan penyemangatnya',
                      labelText: 'Kutipan',
                    ),
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      setState(() {
                        kutipan = value!;
                      });
                    },
                    onChanged: (String? value) {
                      setState(() {
                        kutipan = value!;
                      });
                    },
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Kutipannya tidak boleh kosong.'
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
                            "https://reflekt-io.herokuapp.com/kutipan-penyemangat/add-kutipan-flutter",
                            convert.jsonEncode(<String, String>{
                              'name': nama,
                              'quotes_form': kutipan,
                            }));
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "Kutipan Penyamangat baru telah berhasil disimpan!"),
                          ));
                          Navigator.pushReplacementNamed(
                              context, KutipanPenyemangatHomePage.ROUTE_NAME);
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
