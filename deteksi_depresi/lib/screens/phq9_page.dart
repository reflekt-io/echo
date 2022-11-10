// ignore_for_file: constant_identifier_names

import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:collection/collection.dart';
import 'package:echo/widgets/drawer_menu.dart';
import 'package:deteksi_depresi/models/result.dart';
import 'package:provider/provider.dart';

class PHQ9 extends StatefulWidget {
  const PHQ9({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/deteksi-depresi';

  @override
  State<PHQ9> createState() => _PHQ9State();
}

class _PHQ9State extends State<PHQ9> with RouteAware {
  List<String> questions = [
    "Kurang berminat atau bergairah dalam melakukan apapun",
    "Merasa murung, sedih, atau putus asa",
    "Sulit tidur/mudah terbangun, atau terlalu banyak tidur",
    "Merasa lelah atau kurang bertenaga",
    "Kurang nafsu makan atau terlalu banyak makan",
    "Kurang percaya diri — atau merasa bahwa Anda adalah orang yang gagal atau telah mengecewakan diri sendiri atau keluarga",
    "Sulit berkonsentrasi pada sesuatu, misalnya membaca koran atau menonton televisi",
    "Bergerak atau berbicara sangat lambat sehingga orang lain memperhatikannya. Atau sebaliknya; merasa resah atau gelisah sehingga Anda lebih sering bergerak dari biasanya",
    "Merasa lebih baik mati atau ingin melukai diri sendiri dengan cara apapun"
  ];

  List<Map<String, Object>> choices = [
    {
      'text': 'Tidak pernah',
      'score': 0,
    },
    {
      'text': 'Beberapa hari',
      'score': 1,
    },
    {
      'text': 'Lebih dari seminggu',
      'score': 2,
    },
    {
      'text': 'Hampir setiap hari',
      'score': 3,
    },
  ];

  late List<double> scores = [for (var i = 0; i < questions.length; i++) 0];

  String get resultText {
    String resultText;
    int totalScore = scores.sum as int;
    if (totalScore >= 20) {
      resultText = 'Depresi berat';
    } else if (totalScore >= 15) {
      resultText = 'Depresi sedang';
    } else if (totalScore >= 10) {
      resultText = 'Depresi ringan';
    } else if (totalScore >= 5) {
      resultText = 'Gejala depresi ringan';
    } else {
      resultText = 'Tidak terdapat gejala depresi';
    }
    return resultText;
  }

  @override
  void initState() {
    showResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Health Questionnaire (PHQ-9)'),
      ),
      drawer: const DrawerMenu(PHQ9.ROUTE_NAME),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Dalam 2 minggu terakhir, seberapa sering Anda terganggu oleh masalah-masalah berikut?',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              for (int i = 0; i < questions.length; i++)
                Column(
                  children: [
                    const Divider(
                      thickness: 2.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(questions[i]),
                    ),
                    Slider(
                      value: scores[i],
                      min: 0,
                      max: 3,
                      divisions: 3,
                      label: '${choices[scores[i].round()]['text']}',
                      onChanged: (value) {
                        setState(() {
                          scores[i] = value;
                        });
                      },
                    ),
                  ],
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
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Hasil Deteksi Depresi"),
                          content: Text(resultText),
                        );
                      },
                    );
                    await request.postJson(
                        "https://reflekt-io.herokuapp.com/deteksi-depresi/add-result-flutter",
                        convert.jsonEncode(<String, String>{
                          'result': resultText,
                        }));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showResult() async {
    final request = context.read<CookieRequest>();
    String url =
        'https://reflekt-io.herokuapp.com/deteksi-depresi/fetch-result-flutter';
    Result data;

    final response = await request.get(url);
    data = Result.fromMap(response);

    if (data.result != "") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Hasil Terakhir Deteksi Depresi"),
            content: Text(
                "${data.result} (${data.date.toLocal().toString().substring(0, 16)})"),
          );
        },
      );
    }
  }
}
