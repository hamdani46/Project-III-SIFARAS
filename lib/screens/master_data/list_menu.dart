import 'package:sifaras/screens/dahsboard_page.dart';
import 'package:sifaras/screens/master_data/customer/list.dart';
import 'package:sifaras/screens/master_data/jabatan/list.dart';
import 'package:sifaras/screens/master_data/dokter/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sifaras/screens/master_data/petugas/list.dart';
import 'package:sifaras/screens/master_data/poli/list.dart';

class ListMenuMaster extends StatelessWidget {
  const ListMenuMaster({Key? key}) : super(key: key);

  signOut() async {}

  @override
  Widget build(BuildContext context) {
    Widget _menuMasterData(String Title, Deskripsi, DynamicIcon, Nav) {
      return ListTile(
        leading: Material(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.grey[200],
          child: IconButton(
            padding: EdgeInsets.all(0.0),
            icon: Icon(DynamicIcon),
            color: Colors.amber[500],
            iconSize: 30.0,
            onPressed: () {},
          ),
        ),
        title: Text(Title),
        contentPadding: EdgeInsets.all(7.0),
        subtitle: Text(Deskripsi),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Nav));
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[500],
          title: const Text('Menu Master Data',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: ListView(
          children: [
            _menuMasterData(
                'Dokter', 'Pengelolaan Data Dokter', Icons.group, ListDokter()),
            Divider(),
            _menuMasterData('Spesialis', 'Pengelolaan Data Spesialis',
                Icons.person_add, ListJabatan()),
            Divider(),
            _menuMasterData('Petugas', 'Pengelolaan Data Petugas Poli',
                Icons.people_alt, ListPetugas()),
            Divider(),
            _menuMasterData('Poli', 'Pengelolaan Data Poli',
                Icons.local_hospital, ListPoli()),
            Divider(),
            _menuMasterData('Pasien', 'Pengelolaan Data Pasien',
                Icons.person_add_alt, ListCustomer()),
          ],
        ));
  }
}
