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

class EditJabatan extends StatefulWidget {
  final VoidCallback reload;
  final JabatanModel model;
  EditJabatan(this.model, this.reload);

  @override
  _EditJabatanState createState() => _EditJabatanState();
}

class _EditJabatanState extends State<EditJabatan> {
  String? namaJabatan;
  final _key = new GlobalKey<FormState>();

  TextEditingController? txtNamaJabatan;
  setup() async {
    txtNamaJabatan = TextEditingController(text: widget.model.namaJabatan);
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
      var uri = Uri.parse(BaseUrl.urlUbahJabatan);
      var request = http.MultipartRequest("POST", uri);
      request.fields['id_jabatan'] = widget.model.idJabatan!;
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
              'Edit Jabatan Spesialis Dokter',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                controller: txtNamaJabatan,
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi nama Jabatan";
                  }
                },
                onSaved: (e) => namaJabatan = e,
                decoration: InputDecoration(labelText: "Nama Jabatan"),
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
