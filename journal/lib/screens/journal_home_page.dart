// ignore_for_file: constant_identifier_names, avoid_print

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import 'package:echo/widgets/drawer_menu.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/screens/add_journal_page.dart';
import 'package:journal/widgets/journal_card.dart';
import 'package:provider/provider.dart';

class JournalHomePage extends StatefulWidget {
  const JournalHomePage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/journal';

  @override
  State<JournalHomePage> createState() => _JournalHomePageState();
}

class _JournalHomePageState extends State<JournalHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Jurnal'),
      ),
      drawer: const DrawerMenu(JournalHomePage.ROUTE_NAME),
      body: FutureBuilder(
          future: fetchJournal(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Journal>? journal = snapshot.data as List<Journal>;

              return journal.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Tekan tombol tambah untuk menambahkan jurnal baru.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: journal.length,
                      itemBuilder: (context, index) {
                        return JournalCard(journal[index]);
                      },
                    );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0B36A8),
        onPressed: () {
          Navigator.pushNamed(context, AddJournalPage.ROUTE_NAME);
        },
        tooltip: 'Jurnal Baru',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<Journal>> fetchJournal() async {
    final request = context.watch<CookieRequest>();
    String url = 'https://reflekt-io.herokuapp.com/journal/json';

    final response = await request.get(url);

    List<Journal> result = [];
    for (var d in response) {
      if (d != null) {
        result.add(Journal.fromJson(d));
      }
    }

    return result;
  }
}
