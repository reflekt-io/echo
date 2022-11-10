// ignore_for_file: camel_case_types, non_constant_identifier_names, constant_identifier_names

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import 'package:echo/widgets/drawer_menu.dart';
import 'package:kutipan/screens/add_kutipan_penyemangat_page.dart';
import 'package:kutipan/models/kutipan_penyemangat.dart';
import 'package:kutipan/widgets/kutipan_penyemangat_card.dart';
import 'package:provider/provider.dart';

class KutipanPenyemangatHomePage extends StatefulWidget {
  const KutipanPenyemangatHomePage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/kutipan';

  @override
  State<KutipanPenyemangatHomePage> createState() =>
      _Kutipan_PenyemangatHomePageState();
}

class _Kutipan_PenyemangatHomePageState
    extends State<KutipanPenyemangatHomePage> {
  // List<Kutipan_Penyemangat> dummyKutipan_Penyemangat = DUMMY_CATEGORIES.fields;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Kutipan Penyemangat'),
      ),
      drawer: const DrawerMenu(KutipanPenyemangatHomePage.ROUTE_NAME),
      body: FutureBuilder(
          future: fetchKutipan(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Kutipan_Penyemangat>? kutipan =
                  snapshot.data as List<Kutipan_Penyemangat>;
              return kutipan.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Tekan tombol tambah untuk menambahkan kutipan penyemangat baru.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: kutipan.length,
                      itemBuilder: (context, index) {
                        return KutipanPenyemangatCard(kutipan[index]);
                      },
                    );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0B36A8),
        onPressed: () {
          Navigator.pushNamed(context, AddKutipanPenyemangatPage.ROUTE_NAME);
        },
        tooltip: 'Tambahkan Kutipan Penyemangat',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List<Kutipan_Penyemangat>> fetchKutipan() async {
    final request = context.watch<CookieRequest>();
    String url = 'https://reflekt-io.herokuapp.com/kutipan-penyemangat/json';

    final response = await request.get(url);

    List<Kutipan_Penyemangat> result = [];
    for (var d in response) {
      if (d != null) {
        result.add(Kutipan_Penyemangat.fromJson(d));
      }
    }
    return result;
  }
}
