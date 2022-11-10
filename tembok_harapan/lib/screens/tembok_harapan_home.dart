// ignore_for_file: camel_case_types, non_constant_identifier_names, constant_identifier_names

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:echo/widgets/drawer_menu.dart';
import 'package:tembok_harapan/screens/add_tembok_harapan_page.dart';
import 'package:tembok_harapan/models/tembok_harapan.dart';
import 'package:tembok_harapan/widgets/tembok_harapan_card.dart';

class TembokHarapanHomePage extends StatefulWidget {
  const TembokHarapanHomePage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/tembok-harapan';

  @override
  State<TembokHarapanHomePage> createState() => _Tembok_HarapanHomePageState();
}

class _Tembok_HarapanHomePageState extends State<TembokHarapanHomePage> {
  // List<Tembok_Harapan> dummyTembok_Harapan = DUMMY_CATEGORIES.fields;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kumpulan Harapan'),
      ),
      drawer: const DrawerMenu(TembokHarapanHomePage.ROUTE_NAME),
      body: FutureBuilder(
          future: fetchHarapan(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Tembok_Harapan>? harapan =
                  snapshot.data as List<Tembok_Harapan>;
              return harapan.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Tekan tombol tambah untuk menambahkan harapan baru.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: harapan.length,
                      itemBuilder: (context, index) {
                        return TembokHarapanCard(harapan[index]);
                      },
                    );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0B36A8),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddTembokHarapanPage()));
        },
        tooltip: 'Tambahkan Harapan',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List<Tembok_Harapan>> fetchHarapan() async {
    final request = context.watch<CookieRequest>();
    String url =
        'https://reflekt-io.herokuapp.com/tembok-harapan/json-tembok-harapan';

    final response = await request.get(url);

    List<Tembok_Harapan> result = [];
    for (var d in response) {
      if (d != null) {
        result.add(Tembok_Harapan.fromJson(d));
      }
    }
    return result;
  }
}
