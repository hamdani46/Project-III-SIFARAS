import 'package:sifaras/models/hitung_model.dart';
import 'package:sifaras/screens/master_data/daftar/list_antrian_dokter.dart';
import 'package:sifaras/screens/master_data/list_menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaras/screens/master_data/daftar/list.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../api/api.dart';

class DashboardDokter extends StatefulWidget {
  final VoidCallback signOut;
  DashboardDokter(this.signOut);

  @override
  State<DashboardDokter> createState() => _DashboardDokterState();
}

class _DashboardDokterState extends State<DashboardDokter> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  var value;
  String status = "", username = "", email = "", idUser = "", nama = "";
  getPref() async {
    _hitung();
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
  String? total, ditangani;
  var number = 0, number2 = 0;
  double desimal = 0;
  _hitung() async {
    final response = await http
        .post(Uri.parse(BaseUrl.urlHitungDaftar), body: {"id_user": idUser});
    // final data = jsonDecode(response.body);
    Map<String, dynamic> data = jsonDecode(response.body);
    total = data["total"];
    number = int.parse(total!);

    ditangani = data["ditangani"];
    number2 = int.parse(ditangani!);
    desimal = (number2 / number);
    // percen = int.parse(percen);
    setState(() {
      number;
      number2;
      desimal;
    });
  }

  @override
  void initState() {
    //cari persen
    _hitung();
    super.initState();
    getPref();
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

    ;

    Widget _menuAdmin() {
      return Column(
        children: [
          ListTile(
            title: Text("Master Data"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new ListMenuMaster()));
            },
          ),
          ListTile(
            title: Text("Laporan"),
            onTap: () {},
          ),
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[800],
          title: Text('Dashboard $status $nama',
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
                  color: Colors.lightBlueAccent.shade100,
                ),
              ),
              if (status == "admin") _menuAdmin(),
              ListTile(title: Text("Logout"), onTap: () => signOut()),
            ],
          ),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Text('Halo selamat datang', style: TextStyle(fontSize: 16)),
                    Text('dr. ' + '$username'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 15,
                    ),
                    CircularPercentIndicator(
                      radius: 90.0,
                      animation: true,
                      animationDuration: 1200,
                      lineWidth: 15.0,
                      percent: desimal,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (desimal * 100).ceil().toString() + " %",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30.0),
                          ),
                          Text("$number2 dari $number pasien"),
                          Text("sudah ditangani")
                        ],
                      ),
                      circularStrokeCap: CircularStrokeCap.butt,
                      backgroundColor: Colors.yellow,
                      progressColor: (desimal == 1) ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ),
              Flexible(
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: GridView.count(
                          padding: EdgeInsets.all(20),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: [
                            _menuDashboard('Daftar Antrian',
                                Icons.punch_clock_rounded, ListAntrianDokter()),
                            _menuDashboard('Cetak Laporan', Icons.file_copy,
                                ListAntrianDokter()),
                            // _menuDashboard(
                            //     'Perdin', Icons.bus_alert, AbsenPage()),
                            // _menuDashboard(
                            //     'Gaji', Icons.monetization_on, AbsenPage())
                          ])))
            ])));
  }
}
