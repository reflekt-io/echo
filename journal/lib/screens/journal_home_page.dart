import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:journal/dummy_data.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_json.dart';
import 'package:journal/screens/add_journal_page.dart';
import 'package:journal/widgets/journal_card.dart';

// Jaga-jaga nanti untuk update data, makanya pakai stateful dulu (?)
class JournalHomePage extends StatefulWidget {
  const JournalHomePage({Key? key}) : super(key: key);

  @override
  State<JournalHomePage> createState() => _JournalHomePageState();
}

class _JournalHomePageState extends State<JournalHomePage> {
  List<Journal> dummyJournal = DUMMY_CATEGORIES.fields;
  // List<Journal> dummyJournal = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Jurnal'),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // ignore: sized_box_for_whitespace
            Container(
              width: double.infinity,
              height: 64,
              child: const DrawerHeader(
                child: Text(
                  'reflekt.io',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF24262A),
                ),
              ),
            ),
            ListTile(
              title: const Text('Riwayat Jurnal'),
              onTap: () {
                // Go to Riwayat Jurnal screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Jurnal Baru'),
              onTap: () {
                // Go to Jurnal Baru page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddJournalPage(),
                  ),
                );
              },
            ),
            const Spacer(),
            const Divider(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 25,
                ),
                onTap: () {},
                title: const Text('Akun'),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            dummyJournal.isEmpty
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
                    itemCount: dummyJournal.length,
                    itemBuilder: (context, index) {
                      return JournalCard(dummyJournal[index]);
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0B36A8),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddJournalPage()));
        },
        tooltip: 'Jurnal Baru',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<JournalJson> fetchJournal() async {
    const url = 'https://reflekt-io.herokuapp.com/journal/json/';
    // How to auth?
    JournalJson? data;

    try {
      final response = await http.get(Uri.parse(url));
      print(response.body);
      data = jsonDecode(response.body);
    } catch (error) {
      print(error);
    }

    return data!;
  }
}