import 'dart:convert';

import 'package:sifaras/screens/master_data/jabatan/add.dart';
import 'package:sifaras/screens/master_data/jabatan/edit.dart';
import 'package:flutter/material.dart';
import '../../../api/api.dart';
import '../../../models/jabatan_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';

class ListJabatan extends StatefulWidget {
  @override
  State<ListJabatan> createState() => _ListJabatanState();
}

class _ListJabatanState extends State<ListJabatan> {
  bool loading = true;
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  final list = [];
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  getPref() async {
    _lihatData();
  }

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });

    final response = await http.get(Uri.parse(BaseUrl.urlListJabatan));

    if (response.contentLength == 2) {
      print(response);
    } else {
      print(response);
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new JabatanModel(
            api['id_jabatan'], api['nama_jabatan'], api['log_datetime']);
        list.add(ab);
      });

      setState(() {
        loading = false;
      });
    }
  }

  _proseshapus(String idJabatan) async {
    final response = await http.post(Uri.parse(BaseUrl.urlHapusJabatan),
        body: {"id_jabatan": idJabatan});
    final data = jsonDecode(response.body);
    int value = data['success'];
    String pesan = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
        _lihatData();
      });
    } else {
      print(pesan);
    }
  }

  dialogHapus(String idJabatan) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView(
              padding: EdgeInsets.all(16.0),
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  "Apakah anda yakin ingin menghapus data ini?",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 18.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Tidak",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 25.0),
                    InkWell(
                      onTap: () {
                        _proseshapus(idJabatan);
                      },
                      child: Text(
                        "Ya",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ]),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  var noUrut = 1;

  @override
  Widget build(BuildContext context) {
    Widget _item(data) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          color: Colors.amber[100],
          child: Row(children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("$noUrut.     "),
                  Text(data.namaJabatan),
                ],
              ),
            ),
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditJabatan(data, _lihatData)));
                }),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  dialogHapus(data.idJabatan.toString());
                }),
          ]));
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amber[500],
          title: const Text(
            'Daftar Jabatan Spesialis Dokter',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: RefreshIndicator(
          onRefresh: _lihatData,
          key: _refresh,
          child: loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final data = list[i];
                    noUrut = i + 1;
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: (_item(data)));
                  },
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new AddJabatan(_lihatData)));
        },
        backgroundColor: Colors.amber[500],
        child: const Icon(Icons.add),
      ),
    );
  }
}
