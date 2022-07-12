import 'package:sifaras/screens/master_data/dokter/list.dart';
import 'package:sifaras/screens/master_data/list_menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaras/screens/master_data/poli/list.dart';
// import 'package:sifaras/screens/master_data/ijin_cuti/list.dart';
// import 'package:sifaras/screens/master_data/ijin_cuti/persetujuan.dart';

class DashboardPage extends StatefulWidget {
  final VoidCallback signOut;
  DashboardPage(this.signOut);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  var value;
  String status = "", username = "", email = "";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt('value');
      status = preferences.getString('status')!;
      username = preferences.getString('username')!;
      email = preferences.getString('email')!;
    });
    // print("usernamedahbors" + username);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    Widget _menuDashboard(String Title, DynamicIcon, Nav) {
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.lightBlueAccent,
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
          // ListTile(
          //   title: Text("Persetujuan"),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => new ListPersetujuan()));
          //   },
          // ),
          ListTile(
            title: Text("Laporan"),
            onTap: () {},
          ),
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent.shade100,
          title: Text('Dashboard $status',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        endDrawer: Drawer(
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
              _menuAdmin(),
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
                    Text('$username'.toUpperCase(),
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
                            _menuDashboard('Daftar Dokter',
                                Icons.punch_clock_rounded, ListDokter()),
                            _menuDashboard(
                                'Daftar Poli', Icons.file_copy, ListPoli()),
                            // _menuDashboard(
                            //     'Perdin', Icons.bus_alert, AbsenPage()),
                            // _menuDashboard(
                            //     'Gaji', Icons.monetization_on, AbsenPage())
                          ])))
            ])));
  }
}
