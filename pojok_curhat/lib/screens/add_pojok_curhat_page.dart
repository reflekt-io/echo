// ignore_for_file: constant_identifier_names
import 'dart:convert' as convert;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import 'package:pojok_curhat/screens/pojok_curhat_home.dart';
import 'package:provider/provider.dart';

class AddPojokCurhatPage extends StatefulWidget {
  const AddPojokCurhatPage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/add-curhat';

  @override
  State<AddPojokCurhatPage> createState() => _Pojok_CurhatHomePageState();
}

// ignore: camel_case_types
class _Pojok_CurhatHomePageState extends State<AddPojokCurhatPage> {
  final _formKey = GlobalKey<FormState>();

  // Saved variables to be submitted
  String _typedName = "";
  String _typedTitle = "";
  String _typedMessage = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Curhat Baru'),
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
                    'Bagaimana harimu?',
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
                      icon: Icon(Icons.sticky_note_2),
                      hintText: 'Ayo sini, tulis nama (boleh anonymous).',
                      labelText: 'Dari',
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _typedName = value!;
                      });
                    },
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      setState(() {
                        _typedName = value!;
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
                      hintText: 'Berikan judul pada curhatanmu.',
                      labelText: 'Judul',
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _typedTitle = value!;
                      });
                    },
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      setState(() {
                        _typedTitle = value!;
                      });
                    },
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Judul tidak boleh kosong.'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.sticky_note_2),
                      hintText: 'Ungkapkan curhatanmu',
                      labelText: 'Pesan',
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _typedMessage = value!;
                      });
                    },
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      setState(() {
                        _typedMessage = value!;
                      });
                    },
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Pesan tidak boleh kosong.'
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
                            "https://reflekt-io.herokuapp.com/pojok-curhat/add-curhat-flutter",
                            convert.jsonEncode(<String, String>{
                              'fromCurhat': _typedName,
                              'title': _typedTitle,
                              'message': _typedMessage,
                            }));
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Curhat baru berhasil disimpan!"),
                          ));
                          Navigator.pushReplacementNamed(
                              context, PojokCurhatHomePage.ROUTE_NAME);
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
