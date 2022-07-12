import 'dart:convert';

import 'package:sifaras/screens/master_data/daftar/add.dart';

import 'package:flutter/material.dart';
import 'package:sifaras/screens/master_data/daftar/detail_antrian.dart';
import 'package:sifaras/screens/master_data/daftar/time_line.dart';
import '../../../api/api.dart';
import '../../../models/daftarBerobat_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListAntrianDokter extends StatefulWidget {
  @override
  State<ListAntrianDokter> createState() => _ListAntrianDokterState();
}

class _ListAntrianDokterState extends State<ListAntrianDokter> {
  bool loading = true;
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  final list = [];
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  var value;
  String status = "",
      username = "",
      email = "",
      tanggal = "",
      idUser = "",
      nama = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt('value');
      status = preferences.getString('status')!;
      username = preferences.getString('username')!;
      email = preferences.getString('email')!;
      idUser = preferences.getString('id_user')!;
      nama = preferences.getString('nama_lengkap')!;
      var now = new DateTime.now();
      var formatter = new DateFormat('dd MMMM yyyy');

      tanggal = formatter.format(now);

      _lihatData();
    });
  }

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });

    final response = await http.post(Uri.parse(BaseUrl.urlListAntrianDokter),
        body: {"id_user": idUser});

    if (response.contentLength == 2) {
      print(response);
    } else {
      print(response);
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = DaftarBerobatModel(
            api['id_daftar'],
            api['tanggal'],
            api['id_pasien'],
            api['id_poli'],
            api['id_dokter'],
            api['no_antrian'],
            api['keluhan'],
            api['diagnosa'],
            api['obat'],
            api['pemeriksaan'],
            api['tindakan'],
            api['status'],
            api['nama_dokter'],
            api['nama_pasien'],
            api['nama_poli']);
        list.add(ab);
      });

      setState(() {
        loading = false;
      });
    }
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
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.amber[100],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nama Lengkap'),
                Text(data.namaPasien),
              ],
            )),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status'),
                Text(data.status),
              ],
            )),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nomor Antrian'),
                Text(
                  data.noAntrian,
                  style: const TextStyle(
                    // color: Colors.blue,
                    fontSize: 20, // light
                    fontStyle: FontStyle.italic, // italic
                  ),
                ),
              ],
            )),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                //JANGAN LUPA UBAH
                                new DetailAntrianDokter(data, _lihatData)));
                    // EditDokter(data, _lihatData)));
                  },
                  child: const Text(
                    'detail >>>',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20, // light
                      fontStyle: FontStyle.italic, // italic
                    ),
                  ),
                ),
              ],
            )),
          ]));
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Daftar Antrian Pasien Dr. $nama',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: RefreshIndicator(
          onRefresh: _lihatData,
          key: _refresh,
          child: loading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                          child: Text(
                            "$tanggal",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20, // light
                              fontStyle: FontStyle.italic, // italic
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                          child: Text(""),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, i) {
                          final data = list[i];
                          return Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              child: (_item(data)));
                        },
                      ),
                    ),
                  ],
                )),
    );
  }
}
