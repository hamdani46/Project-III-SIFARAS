import 'dart:convert';

import 'package:sifaras/screens/master_data/daftar/add.dart';

import 'package:flutter/material.dart';
import 'package:sifaras/screens/master_data/daftar/time_line.dart';
import '../../../api/api.dart';
import '../../../models/daftarBerobat_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListDaftarBerobat extends StatefulWidget {
  @override
  State<ListDaftarBerobat> createState() => _ListDaftarBerobatState();
}

class _ListDaftarBerobatState extends State<ListDaftarBerobat> {
  bool loading = true;
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  final list = [];
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  var value;
  String status = "", username = "", email = "", tanggal = "", iduser = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt('value');
      status = preferences.getString('status')!;
      username = preferences.getString('username')!;
      email = preferences.getString('email')!;
      tanggal = preferences.getString('tanggal')!;
      iduser = preferences.getString('id_user')!;
      _lihatData();
    });
  }

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });

    final response = await http.post(Uri.parse(BaseUrl.urlListDaftarBerobat),
        body: {"id_user": iduser});

    if (response.contentLength == 2) {
      print(response);
    } else {
      print(response);
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new DaftarBerobatModel(
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
            Text(data.tanggal, style: TextStyle(fontWeight: FontWeight.bold)),
            Divider(),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nama Poli'),
                Text(data.namaPoli),
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
                                new DaftarTimeLine(data, _lihatData)));
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
            // Container(
            //     color: (absenKeluar == "-") ? Colors.red : Colors.amber[100],
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text('Absen Keluar'),
            //         Text('$absenKeluar'),
            //       ],
            //     )),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Keterangan'),
            //     Text('$ket'),
            //   ],
            // )
          ]));
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[500],
          title: const Text(
            'Daftar Antrian',
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
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: (_item(data)));
                  },
                )),
    );
  }
}
