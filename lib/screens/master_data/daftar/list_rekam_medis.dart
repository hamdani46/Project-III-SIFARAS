import 'dart:convert';

import 'package:sifaras/screens/master_data/daftar/add.dart';

import 'package:flutter/material.dart';
import '../../../api/api.dart';
import '../../../models/daftarBerobat_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListRekamMedis extends StatefulWidget {
  @override
  State<ListRekamMedis> createState() => _ListRekamMedisState();
}

class _ListRekamMedisState extends State<ListRekamMedis> {
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

  // _proseshapus(String idIjin) async {
  //   final response = await http.post(Uri.parse(BaseUrl.urlHapusDaftarBerobat),
  //       body: {"id_ijin": idIjin});
  //   final data = jsonDecode(response.body);
  //   int value = data['success'];
  //   String pesan = data['message'];
  //   if (value == 1) {
  //     setState(() {
  //       Navigator.pop(context);
  //       _lihatData();
  //     });
  //   } else {
  //     print(pesan);
  //     print(idIjin);
  //   }
  // }

  // dialogHapus(String idIjin) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         child: ListView(
  //             padding: EdgeInsets.all(16.0),
  //             shrinkWrap: true,
  //             children: <Widget>[
  //               Text(
  //                 "Apakah anda yakin ingin menghapus data ini?",
  //                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
  //               ),
  //               SizedBox(height: 18.0),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: <Widget>[
  //                   InkWell(
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: Text(
  //                       "Tidak",
  //                       style: TextStyle(
  //                           fontSize: 18.0, fontWeight: FontWeight.bold),
  //                     ),
  //                   ),
  //                   SizedBox(width: 25.0),
  //                   InkWell(
  //                     onTap: () {
  //                       _proseshapus(idIjin);
  //                     },
  //                     child: Text(
  //                       "Ya",
  //                       style: TextStyle(
  //                           fontSize: 18.0, fontWeight: FontWeight.bold),
  //                     ),
  //                   )
  //                 ],
  //               )
  //             ]),
  //       );
  //     },
  //   );
  // }

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
                Text('Diagnosa'),
                Text(data.diagnosa),
              ],
            )),
            // Container(
            //     child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Nama Dokter'),
            //     Text(data.namaDokter),
            //   ],
            // )),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tindakan'),
                Text(data.tindakan),
              ],
            )),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Obat'),
                Text(data.obat),
              ],
            )),
          ]));
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[500],
          title: const Text(
            'Rekam Medis',
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
    );
  }
}
