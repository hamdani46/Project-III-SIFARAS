import 'dart:convert';

import 'package:sifaras/screens/master_data/dokter/add.dart';
import 'package:sifaras/screens/master_data/dokter/edit.dart';
import 'package:flutter/material.dart';
import 'package:sifaras/screens/master_data/dokter/list_cari.dart';
import 'package:sifaras/screens/master_data/dokter/list_search.dart';
import 'package:sifaras/screens/master_data/list_menu.dart';
import '../../../api/api.dart';
import '../../../models/dokter_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListDokter extends StatefulWidget {
  @override
  State<ListDokter> createState() => _ListDokterState();
}

class _ListDokterState extends State<ListDokter> {
  bool loading = true;
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  final list = [];
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  var value;
  String status = "", username = "", email = "", idPasien = "", nama = "";

  getPref() async {
    _lihatData();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt('value');
      status = preferences.getString('status')!;
      username = preferences.getString('username')!;
      email = preferences.getString('email')!;
      idPasien = preferences.getString('id_user')!;
      nama = preferences.getString('nama_lengkap')!;
    });
  }

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });

    final response = await http.get(Uri.parse(BaseUrl.urlListDokter));

    if (response.contentLength == 2) {
      print(response);
    } else {
      print(response);
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new DokterModel(
            api['id_user'],
            api['nama_lengkap'],
            api['jenis_kelamin'],
            api['tanggal_lahir'],
            api['nama_jabatan'],
            api['tanggal_gabung'],
            api['log_datetime'],
            api['id_jabatan'],
            api['id_poli']);
        list.add(ab);
      });

      setState(() {
        loading = false;
      });
    }
  }

  _proseshapus(String idUser) async {
    final response = await http
        .post(Uri.parse(BaseUrl.urlHapusDokter), body: {"id_user": idUser});
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
      print(idUser);
    }
  }

  dialogHapus(String idUser) {
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
                        _proseshapus(idUser);
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
          color: Colors.blue[100],
          child: Row(children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Container(child: Text("$noUrut."), width: 25),
                      Container(
                        child: Text(data.namaLengkap),
                        width: 90,
                      ),
                      Container(
                        child: Text("Dokter " + data.namaJabatan),
                      ),
                    ],
                  ),

                  // Text(data.namaJabatan, textAlign: TextAlign.right,)
                ],
              ),
            ),
            if (status == "admin")
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EditDokter(data, _lihatData)));
                      }),
                ],
              ),
            if (status == "admin")
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    dialogHapus(data.idUser.toString());
                  }),
          ]));
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[500],
          title: const Text(
            'Daftar Dokter',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            //jika search bernilai false maka tampilkan icon search
            //jika search bernilai true maka tampilkan icon close
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                    // MaterialPageRoute(builder: (context) => SearchList()));
                    MaterialPageRoute(builder: (context) => ListCari()));
              },
            )
          ]),
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
      floatingActionButton: Column(
        children: [
          if (status == "admin")
            FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new AddDokter(_lihatData)));
              },
              backgroundColor: Colors.blue[500],
              child: const Icon(Icons.add),
            ),
        ],
      ),
    );
  }
}
