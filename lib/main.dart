import 'package:sifaras/screens/dahsboard_page.dart';
import 'package:sifaras/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:sifaras/screens/master_data/dokter/list_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ASIK - Aplikasi Sistem Kepegawaian',
        debugShowCheckedModeBanner: false,
        home: LoginPage());
    // home: SearchList());
  }
}
