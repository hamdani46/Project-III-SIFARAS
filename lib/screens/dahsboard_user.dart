import 'package:sifaras/screens/master_data/daftar/add.dart';
import 'package:sifaras/screens/master_data/daftar/list_rekam_medis.dart';
import 'package:sifaras/screens/master_data/dokter/list.dart';
import 'package:sifaras/screens/master_data/list_menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaras/screens/master_data/daftar/list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../api/api.dart';

import '../models/daftarBerobat_model.dart';

class DashboardUser extends StatefulWidget {
  final VoidCallback signOut;
  DashboardUser(this.signOut);

  @override
  State<DashboardUser> createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  var value;
  String status = "", username = "", email = "", idUser = "", nama = "";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt('value');
      status = preferences.getString('status')!;
      username = preferences.getString('username')!;
      email = preferences.getString('email')!;
      idUser = preferences.getString('id_user')!;
      nama = preferences.getString('nama_lengkap')!;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getPref();
  }

  final list = [];
  bool loading = true;

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });

    final response = await http.post(Uri.parse(BaseUrl.urlListDaftarBerobat),
        body: {"id_user": idUser});

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
  Widget build(BuildContext context) {
    Widget _menuDashboard(String Title, DynamicIcon, Nav) {
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.lightBlueAccent.shade100,
          ),
          child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Nav));
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      DynamicIcon,
                      color: Colors.white,
                      size: 50,
                    ),
                    Text(
                      '$Title',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ])));
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[500],
          title: Text('Dashboard $status',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(username),
                accountEmail: Text(status),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: AssetImage('assets/img/user.png'),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[500],
                ),
              ),
              ListTile(title: Text("Logout"), onTap: () => signOut()),
            ],
          ),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Text('Halo selamat datang', style: TextStyle(fontSize: 16)),
                    Text('$nama'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600)),
                    // Text('Have a nice day.. ', style: TextStyle(fontSize: 16))
                  ],
                ),
              ),
              Flexible(
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 40),
                      child: GridView.count(
                          padding: EdgeInsets.all(20),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: [
                            _menuDashboard(
                                'Daftar Berobat',
                                Icons.punch_clock_rounded,
                                AddDaftarBerobat(_lihatData)),
                            _menuDashboard('Cek Antrian', Icons.file_copy,
                                ListDaftarBerobat()),
                            _menuDashboard('Rekam Medis', Icons.bus_alert,
                                ListRekamMedis()),
                            _menuDashboard('lihat dokter',
                                Icons.monetization_on, ListDokter())
                          ])))
            ])));
  }
}
