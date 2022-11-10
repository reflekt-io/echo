// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:echo/widgets/drawer_menu.dart';
import 'package:ide_kegiatan/models/kegiatan.dart';
import 'package:ide_kegiatan/models/rekomendasi.dart';
import 'package:ide_kegiatan/screens/add_ide_kegiatan.dart';
import 'package:ide_kegiatan/widgets/kegiatan_card.dart';
import 'package:ide_kegiatan/widgets/rekomendasi_card.dart';

class IdeKegiatanHomePage extends StatefulWidget {
  const IdeKegiatanHomePage({Key? key}) : super(key: key);
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/refleksi';

  @override
  State<IdeKegiatanHomePage> createState() => _IdeKegiatanHomePageState();
}

class _IdeKegiatanHomePageState extends State<IdeKegiatanHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ide Kegiatan'),
      ),
      drawer: const DrawerMenu(IdeKegiatanHomePage.ROUTE_NAME),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                  left: 30, top: 20, right: 30, bottom: 0),
              child: const Text("Kegiatan yang pernah kamu lakukan sebelumnya",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 10, top: 0, right: 10, bottom: 15),
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(
                minHeight: 30,
                maxHeight: 375,
              ),
              child: FutureBuilder(
                  future: fetchKegiatan(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Kegiatan>? kegiatan =
                          snapshot.data as List<Kegiatan>;
                      return kegiatan.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 30.0),
                                child: Text(
                                  'Belum ada kegiatan yang kamu tambahkan.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: kegiatan.length,
                              itemBuilder: (context, index) {
                                return KegiatanCard(kegiatan[index]);
                              },
                            );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 0),
              child: const Text(
                  "Beberapa rekomendasi kegiatan yang dapat kamu lakukan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 10, top: 0, right: 10, bottom: 20),
              padding: const EdgeInsets.all(10),
              height: 380,
              child: FutureBuilder(
                  future: fetchRekomendasi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Rekomendasi>? rekomendasi =
                          snapshot.data as List<Rekomendasi>;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: rekomendasi.length,
                        itemBuilder: (context, index) {
                          return RekomendasiCard(rekomendasi[index]);
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0B36A8),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddRekomendasiKegiatanPage()));
        },
        tooltip: 'Tambah Kegiatan',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<Kegiatan>> fetchKegiatan() async {
    final request = context.watch<CookieRequest>();
    String url = 'https://reflekt-io.herokuapp.com/refleksi/add-deskripsi';

    final response = await request.get(url);

    List<Kegiatan> result = [];
    for (var d in response) {
      if (d != null) {
        result.add(Kegiatan.fromJson(d));
      }
    }

    return result;
  }

  Future<List<Rekomendasi>> fetchRekomendasi() async {
    final request = context.watch<CookieRequest>();
    String url = 'https://reflekt-io.herokuapp.com/refleksi/add-deskripsi';

    final response = await request.get(url);

    List<Rekomendasi> result = [
      Rekomendasi(nama: 'Bermain game'),
      Rekomendasi(nama: 'Menonton film'),
      Rekomendasi(nama: 'Membaca buku'),
      Rekomendasi(nama: 'Mendengarkan musik'),
      Rekomendasi(nama: 'Belanja'),
      Rekomendasi(nama: 'Mengunjungi tempat wisata'),
      Rekomendasi(nama: 'Olahraga'),
      Rekomendasi(nama: 'Menulis'),
      Rekomendasi(nama: 'Memasak'),
      Rekomendasi(nama: 'Membersihkan rumah')
    ];

    List<String> listNama = [
      'bermain game',
      'menonton film',
      'membaca buku',
      'mendengarkan musik',
      'belanja',
      'mengunjungi tempat wisata',
      'olahraga',
      'menulis',
      'memasak',
      'membersihkan rumah'
    ];

    for (var d in response) {
      if (d != null && !listNama.contains(d["fields"]["nama"].toLowerCase())) {
        result.add(Rekomendasi.fromJson(d));
        listNama.add(d["fields"]["nama"].toLowerCase());
      }
    }

    return result;
  }
}
