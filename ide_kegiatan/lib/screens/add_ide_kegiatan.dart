import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:ide_kegiatan/screens/ide_kegiatan_home.dart';

class AddRekomendasiKegiatanPage extends StatefulWidget {
  const AddRekomendasiKegiatanPage({Key? key}) : super(key: key);
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/add-kegiatan';

  @override
  State<AddRekomendasiKegiatanPage> createState() =>
      _IdeKegiatanHomePageState();
}

class _IdeKegiatanHomePageState extends State<AddRekomendasiKegiatanPage> {
  final _formKey = GlobalKey<FormState>();
  String _nama = "";
  String _deskripsi = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kegiatan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 400,
              child: Stack(
                children: <Widget>[
                  const Positioned(
                    left: 25,
                    top: 20,
                    right: 25,
                    child: Text('Silakan tambahkan rekomendasi kegiatanmu',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22)),
                  ),
                  Positioned(
                    left: 15,
                    top: 90,
                    right: 15,
                    bottom: 15,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLength: 40,
                              decoration: InputDecoration(
                                hintText: "Contoh: Bermain game",
                                labelText: "Nama Kegiatan",
                                icon: const Icon(Icons.event_note),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  _nama = value!;
                                });
                              },
                              onSaved: (String? value) {
                                _nama = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Nama kegiatan tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLines: 2,
                              maxLength: 60,
                              decoration: InputDecoration(
                                hintText:
                                    "Contoh: Bermain Ludo King bersama teman-teman",
                                labelText: "Deskripsi Kegiatan",
                                icon: const Icon(Icons.sticky_note_2_outlined),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  _deskripsi = value!;
                                });
                              },
                              onSaved: (String? value) {
                                _deskripsi = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Deskripsi kegiatan tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),
                          TextButton(
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF0B36A8)),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Submit to Django server and wait for response
                                final response = await request.postJson(
                                    "https://reflekt-io.herokuapp.com/refleksi/add-kegiatan-flutter",
                                    convert.jsonEncode(<String, String>{
                                      'nama': _nama.toString(),
                                      'deskripsi': _deskripsi.toString(),
                                    }));
                                if (response != '') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text("Kegiatan berhasil disimpan!"),
                                  ));
                                  Navigator.pushReplacementNamed(
                                      context, IdeKegiatanHomePage.ROUTE_NAME);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
