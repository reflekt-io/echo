// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import 'package:echo/widgets/drawer_menu.dart';
import 'package:pojok_curhat/screens/add_pojok_curhat_page.dart';
import 'package:pojok_curhat/models/pojok_curhat.dart';
import 'package:pojok_curhat/widgets/pojok_curhat_card.dart';
import 'package:provider/provider.dart';

class PojokCurhatHomePage extends StatefulWidget {
  const PojokCurhatHomePage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/pojok-curhat';

  @override
  State<PojokCurhatHomePage> createState() => _PojokCurhatHomePageState();
}

// ignore: camel_case_types
class _PojokCurhatHomePageState extends State<PojokCurhatHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Curhat'),
      ),
      drawer: const DrawerMenu(PojokCurhatHomePage.ROUTE_NAME),
      body: FutureBuilder(
          future: fetchCurhat(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Pojok_Curhat>? curhat = snapshot.data as List<Pojok_Curhat>;

              return curhat.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Tekan tombol tambah untuk menambahkan curhat baru.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: curhat.length,
                      itemBuilder: (context, index) {
                        return PojokCurhatCard(curhat[index]);
                      },
                    );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0B36A8),
        onPressed: () {
          Navigator.pushNamed(context, AddPojokCurhatPage.ROUTE_NAME);
        },
        tooltip: 'Curhat Baru',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List<Pojok_Curhat>> fetchCurhat() async {
    final request = context.watch<CookieRequest>();
    String url = 'https://reflekt-io.herokuapp.com/pojok-curhat/json';

    final response = await request.get(url);

    List<Pojok_Curhat> result = [];
    for (var d in response) {
      if (d != null) {
        result.add(Pojok_Curhat.fromJson(d));
      }
    }

    return result;
  }
}
