// ignore_for_file: constant_identifier_names, avoid_print

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:about_us/screens/about_us.dart';
import 'package:deteksi_depresi/screens/phq9_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:echo/widgets/drawer_menu.dart';
import 'package:ide_kegiatan/screens/add_ide_kegiatan.dart';
import 'package:ide_kegiatan/screens/ide_kegiatan_home.dart';
import 'package:journal/screens/add_journal_page.dart';
import 'package:journal/screens/journal_home_page.dart';
import 'package:kutipan/screens/add_kutipan_penyemangat_page.dart';
import 'package:kutipan/screens/kutipan_penyemangat_home.dart';
import 'package:pojok_curhat/screens/add_pojok_curhat_page.dart';
import 'package:pojok_curhat/screens/pojok_curhat_home.dart';
import 'package:tembok_harapan/screens/add_tembok_harapan_page.dart';
import 'package:tembok_harapan/screens/tembok_harapan_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/home';

  // Color themes
  static const blackColorTheme = Color(0xFF24262A);
  static const blueColorTheme = Color(0xFF0B36A8);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   // Nanti jangan pakai const (variable, cuy)
        //   'Halo, ${request.username}!',
        // ),
      ),
      drawer: const DrawerMenu(ROUTE_NAME),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Apa yang ingin kamu lakukan hari ini?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: <Widget>[
                  Material(
                    color: blueColorTheme,
                    child: InkWell(
                      onTap: () {
                        // Go to the screen
                        Navigator.pushReplacementNamed(
                            context, PHQ9.ROUTE_NAME);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Padding(padding: EdgeInsets.all(3)),
                              Text(
                                "Deteksi Dini Depresi",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: blueColorTheme,
                    child: InkWell(
                      onTap: () {
                        // Go to KutipanPenyemangatHomePage
                        Navigator.pushReplacementNamed(
                            context, KutipanPenyemangatHomePage.ROUTE_NAME);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.format_quote,
                                color: Colors.white,
                                size: 40.0,
                              ),
                              Padding(padding: EdgeInsets.all(1)),
                              Text(
                                "Lihat Kutipan Penyemangat",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: blueColorTheme,
                    child: InkWell(
                      onTap: () {
                        // Go to AddKutipanPenyemangatPage
                        Navigator.pushNamed(
                            context, AddKutipanPenyemangatPage.ROUTE_NAME);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.speaker_notes,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Padding(padding: EdgeInsets.all(3)),
                              Text(
                                "Buat Kutipan Penyemangat",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: blueColorTheme,
                    child: InkWell(
                      onTap: () {
                        // Go to JournalHomePage
                        Navigator.pushNamed(
                            context, JournalHomePage.ROUTE_NAME);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.library_books,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Padding(padding: EdgeInsets.all(3)),
                              Text(
                                "Lihat Riwayat Jurnal",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: blueColorTheme,
                    child: InkWell(
                      onTap: () {
                        // Go to AddJournalPage
                        Navigator.pushNamed(context, AddJournalPage.ROUTE_NAME);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Padding(padding: EdgeInsets.all(3)),
                              Text(
                                "Buat Jurnal Baru",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: blueColorTheme,
                    child: InkWell(
                      onTap: () {
                        // Go to ide kegiatan homepage
                        Navigator.pushNamed(
                            context, IdeKegiatanHomePage.ROUTE_NAME);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.directions_walk,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Padding(padding: EdgeInsets.all(3)),
                              Text(
                                "Lihat Ide Kegiatan",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: blueColorTheme,
                    child: InkWell(
                      onTap: () {
                        // Go to add ide kegiatan page
                        Navigator.pushNamed(
                            context, AddRekomendasiKegiatanPage.ROUTE_NAME);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.lightbulb,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Padding(padding: EdgeInsets.all(3)),
                              Text(
                                "Buat Ide Kegiatan Baru",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: blueColorTheme,
                    child: InkWell(
                      onTap: () {
                        // Go to the screen
                        Navigator.pushReplacementNamed(
                            context, PojokCurhatHomePage.ROUTE_NAME);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.door_front_door,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Padding(padding: EdgeInsets.all(3)),
                              Text(
                                "Lihat Pojok Curhat",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: blueColorTheme,
                    child: InkWell(
                      onTap: () {
                        // Go to the screen
                        Navigator.pushNamed(
                            context, AddPojokCurhatPage.ROUTE_NAME);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.note_add,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Padding(padding: EdgeInsets.all(3)),
                              Text(
                                "Buat Kartu Curhat Baru",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: blueColorTheme,
                    child: InkWell(
                      onTap: () {
                        // Go to ... screen
                        Navigator.pushReplacementNamed(
                            context, TembokHarapanHomePage.ROUTE_NAME);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                CupertinoIcons.paperplane,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Padding(padding: EdgeInsets.all(3)),
                              Text(
                                "Lihat Tembok Harapan",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: blueColorTheme,
                    child: InkWell(
                      onTap: () {
                        // Go to ... screen
                        Navigator.pushNamed(
                            context, AddTembokHarapanPage.ROUTE_NAME);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Padding(padding: EdgeInsets.all(3)),
                              Text(
                                "Buat Harapan Baru",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: blueColorTheme,
                    child: InkWell(
                      onTap: () {
                        // Go to AboutUs screen
                        Navigator.pushNamed(context, AboutUs.ROUTE_NAME);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.people,
                                color: Colors.white,
                                size: 40.0,
                              ),
                              Padding(padding: EdgeInsets.all(1)),
                              Text(
                                "Tentang Kami",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
