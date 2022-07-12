import 'dart:convert';

import 'package:sifaras/screens/master_data/poli/add.dart';
import 'package:sifaras/screens/master_data/poli/edit.dart';
import 'package:flutter/material.dart';
import '../../../api/api.dart';
import '../../../models/poli_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';

class ListPoli extends StatefulWidget {
  @override
  State<ListPoli> createState() => _ListPoliState();
}

class _ListPoliState extends State<ListPoli> {
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

    final response = await http.get(Uri.parse(BaseUrl.urlListPoli));

    if (response.contentLength == 2) {
      print(response);
    } else {
      print(response);
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new PoliModel(
            api['id_poli'], api['nama_poli'], api['log_datetime']);
        list.add(ab);
      });

      setState(() {
        loading = false;
      });
    }
  }

  _proseshapus(String idPoli) async {
    final response = await http
        .post(Uri.parse(BaseUrl.urlHapusPoli), body: {"id_poli": idPoli});
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

  dialogHapus(String idPoli) {
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
                        _proseshapus(idPoli);
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
                  Text(data.namaPoli),
                ],
              ),
            ),
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditPoli(data, _lihatData)));
                }),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  dialogHapus(data.idPoli.toString());
                }),
          ]));
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amber[500],
          title: const Text(
            'Daftar Poli',
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => new AddPoli(_lihatData)));
        },
        backgroundColor: Colors.amber[500],
        child: const Icon(Icons.add),
      ),
    );
  }
}
