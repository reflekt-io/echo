// Generated with https://app.quicktype.io/

// To parse this JSON data, do
//
//     final JournalJson = journalJsonFromMap(jsonString);

import 'dart:convert';

import 'package:journal/models/journal.dart';

class JournalJson {
    // pk -> primary key from serialization

    JournalJson({
        required this.model,
        required this.pk,
        required this.fields,
    });

    final String model;
    final int pk;
    final List<Journal> fields;

    factory JournalJson.fromJson(String str) => JournalJson.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory JournalJson.fromMap(Map<String, dynamic> json) => JournalJson(
        model: json["model"],
        pk: json["pk"],
        fields: List<Journal>.from(json["fields"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "model": model,
        "pk": pk,
        "fields": List<dynamic>.from(fields.map((x) => x)),
    };
}