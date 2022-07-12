import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

import '../../../models/poli_model.dart';
import '../../../api/api.dart';

class EditPoli extends StatefulWidget {
  final VoidCallback reload;
  final PoliModel model;
  EditPoli(this.model, this.reload);

  @override
  _EditPoliState createState() => _EditPoliState();
}

class _EditPoliState extends State<EditPoli> {
  String? namaPoli;
  final _key = new GlobalKey<FormState>();

  TextEditingController? txtNamaPoli;
  setup() async {
    txtNamaPoli = TextEditingController(text: widget.model.namaPoli);
  }

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      proses();
    }
  }

  proses() async {
    try {
      var uri = Uri.parse(BaseUrl.urlUbahPoli);
      var request = http.MultipartRequest("POST", uri);
      request.fields['id_poli'] = widget.model.idPoli!;
      request.fields['namaPoli'] = namaPoli!;

      var response = await request.send();
      if (response.statusCode > 2) {
        if (this.mounted) {
          setState(() {
            widget.reload();
            Navigator.pop(context);
          });
        }
      } else {
        print("Data Gagal Diubah");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final TextStyle valueStyle = TextStyle(fontSize: 16.0);

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        appBar: AppBar(
            backgroundColor: Colors.amber[500],
            title: const Text(
              'Edit Poli Spesialis Dokter',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                controller: txtNamaPoli,
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi nama Poli";
                  }
                },
                onSaved: (e) => namaPoli = e,
                decoration: InputDecoration(labelText: "Nama Poli"),
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
