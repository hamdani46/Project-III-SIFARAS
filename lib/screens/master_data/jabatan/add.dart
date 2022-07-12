import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

import '../../../models/jabatan_model.dart';
import '../../../api/api.dart';

class AddJabatan extends StatefulWidget {
  final VoidCallback reload;
  AddJabatan(this.reload);

  @override
  _AddJabatanState createState() => _AddJabatanState();
}

class _AddJabatanState extends State<AddJabatan> {
  String? namaJabatan;
  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      proses();
    }
  }

  proses() async {
    try {
      var uri = Uri.parse(BaseUrl.urlTambahJabatan);
      var request = http.MultipartRequest("POST", uri);
      request.fields['namaJabatan'] = namaJabatan!;

      var response = await request.send();
      if (response.statusCode > 2) {
        if (this.mounted) {
          setState(() {
            widget.reload();
            Navigator.pop(context);
          });
        }
      } else {
        print("Data Gagal Ditambahkan");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final TextStyle valueStyle = TextStyle(fontSize: 16.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        appBar: AppBar(
            backgroundColor: Colors.amber[500],
            title: const Text(
              'Tambah Jabatan Spesialis Dokter',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi nama spesialis";
                  }
                },
                onSaved: (e) => namaJabatan = e,
                decoration:
                    InputDecoration(labelText: "Nama Jabatan Spesialis"),
              ),
              MaterialButton(
                padding: EdgeInsets.all(25.0),
                color: Colors.amber[500],
                onPressed: () => check(),
                child: Text(
                  'Simpan',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
