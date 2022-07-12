import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

import '../../../api/api.dart';
import 'package:sifaras/custom/datePicker.dart';
import 'package:email_validator/email_validator.dart';

class AddCustomer extends StatefulWidget {
  final VoidCallback reload;
  AddCustomer(this.reload);

  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  String? namaPegawai,
      jenisKelamin = 'laki-laki',
      userName,
      password,
      email,
      alamat;
  // tanggalGabung;
  final _key = new GlobalKey<FormState>();

  final TextEditingController _userController = new TextEditingController();

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      proses();
    }
  }

  proses() async {
    try {
      var uri = Uri.parse(BaseUrl.urlTambahCustomer);
      var request = http.MultipartRequest("POST", uri);
      request.fields['user_name'] = userName!;
      request.fields['password'] = password!;
      request.fields['email'] = email!;
      request.fields['nama_lengkap'] = namaPegawai!;
      request.fields['jenis_kelamin'] = jenisKelamin!;
      request.fields['tanggal_lahir'] = "$tanggalLahir";

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

  String? pilihTanggal, labelText;
  DateTime tanggalLahir = new DateTime.now();
  DateTime tanggalGabung = new DateTime.now();

  final TextStyle valueStyle = TextStyle(fontSize: 16.0);

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: tanggalLahir,
        firstDate: DateTime(1972),
        lastDate: DateTime(2099));
    if (picked != null && picked != tanggalLahir) {
      setState(() {
        tanggalLahir = picked;
        pilihTanggal = new DateFormat.yMd().format(tanggalLahir);
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
        appBar: AppBar(
            backgroundColor: Colors.blue[500],
            title: const Text(
              'Tambah Customer',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: Form(
            key: _key,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                // padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    validator: (e) {
                      if ((e as dynamic).isEmpty) {
                        return "Silahkan isi username";
                      }
                    },
                    onSaved: (e) => userName = e,
                    decoration: const InputDecoration(labelText: "User Name"),
                  ),
                  TextFormField(
                    validator: (e) {
                      if ((e as dynamic).isEmpty) {
                        return "Silahkan isi password";
                      }
                    },
                    onSaved: (e) => password = e,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  TextFormField(
                    validator: (e) {
                      if ((e as dynamic).isEmpty) {
                        return "Silahkan isi email";
                      } else if (!EmailValidator.validate(e!)) {
                        return "Invalid Email Address";
                      }
                    },
                    onSaved: (e) => email = e,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                  TextFormField(
                    validator: (e) {
                      if ((e as dynamic).isEmpty) {
                        return "Silahkan isi nama lengkap";
                      }
                    },
                    onSaved: (e) => namaPegawai = e,
                    decoration: InputDecoration(labelText: "Nama Lengkap"),
                  ),
                  Container(child: Text("Jenis Kelamin")),
                  DropdownButton(
                    alignment: Alignment.topLeft,
                    // style: valueStyle,
                    value: jenisKelamin,
                    items: <String>['laki-laki', 'perempuan']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        jenisKelamin = newValue!;
                      });
                    },
                  ),
                  Text("Tanggal Lahir"),
                  DateDropDown(
                    labelText: labelText,
                    valueText: new DateFormat("d MMM y").format(tanggalLahir),
                    valueStyle: valueStyle,
                    onPressed: () {
                      _selectedDate(context);
                    },
                  ),
                  Center(
                    child: Container(
                      // alignment: Alignment.center,
                      // color: Colors.blue,
                      width: double.infinity,
                      child: MaterialButton(
                        padding: EdgeInsets.all(25.0),
                        color: Colors.blue[500],
                        onPressed: () => check(),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
