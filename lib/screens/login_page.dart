import 'dart:convert';
import 'package:sifaras/screens/dahsboard_page.dart';
import 'package:sifaras/screens/dahsboard_dokter.dart';
import 'package:sifaras/screens/dahsboard_user.dart';
import 'package:flutter/material.dart';
import 'package:sifaras/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'master_data/customer/add.dart';
// import 'master_data/ijin_cuti/list.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn, signUser, signDokter }

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String? inputUsername, inputPassword;
  final _key = new GlobalKey<FormState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  var _autovalidate = false;

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      login();
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  login() async {
    final response = await http.post(Uri.parse(BaseUrl.urlLogin),
        body: {"username": inputUsername, "password": inputPassword});
    final data = jsonDecode(response.body);
    int value = data['success'];
    String pesan = data['message'];

    // var now = new DateTime.now();
    // var formatter = new DateFormat('yyyy-MM-dd');
    // var timer = new DateFormat('H:m:s');
    // var hour = new DateFormat('H');

    // String formattedDate = formatter.format(now);
    // String formattedtime = timer.format(now);
    // var formathour = int.parse(hour.format(now));
    String usernameAPI = data['username'];

    String namaAPI = data['nama_lengkap'];
    String statusAPI = data['status'];
    String userIdAPI = data['id_user'];

    // print("username :" + usernameAPI);
    // print("nama :" + namaAPI);
    // print("status :" + statusAPI);

    if (value == 1) {
      if (statusAPI == "admin") {
        setState(() => _loginStatus = LoginStatus.signIn);
        savePref(value, statusAPI, usernameAPI, namaAPI, userIdAPI);
      } else if (statusAPI == "dokter") {
        setState(() => _loginStatus = LoginStatus.signDokter);
        savePref(value, statusAPI, usernameAPI, namaAPI, userIdAPI);
      } else {
        setState(() => _loginStatus = LoginStatus.signUser);
        savePref(value, statusAPI, usernameAPI, namaAPI, userIdAPI);
      }
      print(pesan);
    } else {
      print(pesan);
    }
  }

  savePref(int val, String statusAPI, String usernameAPI, String namaAPI,
      String userIdAPI) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", val);
      preferences.setString("status", statusAPI);
      preferences.setString("username", usernameAPI);
      preferences.setString("nama_lengkap", namaAPI);
      preferences.setString("id_user", userIdAPI);
      preferences.commit();
    });
  }

  var value, status, username, nama;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt('value');
      status = preferences.getString('status');
      username = preferences.getString('username');
      nama = preferences.getString('nama_lengkap');

      if (value == 1) {
        if (status == "admin") {
          _loginStatus = LoginStatus.signIn;
        } else if (status == "dokter") {
          _loginStatus = LoginStatus.signDokter;
        } else {
          _loginStatus = LoginStatus.signUser;
        }
      } else {
        _loginStatus = LoginStatus.notSignIn;
      }
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
      preferences.setString("status", "");
      preferences.setString("username", "");
      preferences.setString("nama_lengkap", "");
      preferences.setString("status", "");
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  Future<void> _lihatData() async {}

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
            body: Form(
          key: _key,
          // autovalidate: _autovalidate,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: EdgeInsets.only(top: 90.0, left: 20.0, right: 20.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 40.0),
                child: Column(
                  children: [
                    Text(
                      "SIFARAS",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 28.0),
                    ),
                    Text(
                      " Sistem Pendaftaran Rumah Sakit ",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/img/logo2.png',
                height: 100,
              ),
              SizedBox(height: 40.0),
              TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'User Name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                validator: (e) {
                  if (e!.isEmpty) {
                    return "Silahkan isi username";
                  } else {
                    return null;
                  }
                },
                onSaved: (e) => inputUsername = e,
              ),
              SizedBox(height: 15.0),
              TextFormField(
                obscureText: _secureText,
                onSaved: (e) => inputPassword = e,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                      icon: Icon(_secureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: showHide),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 40.0),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                child: Material(
                  //Wrap with Material
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                  elevation: 18.0,
                  shadowColor: Colors.lightBlueAccent.shade100,
                  clipBehavior: Clip.antiAlias, // Add This
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 47,
                    color: Colors.lightBlueAccent,
                    child: new Text('Masuk',
                        style:
                            new TextStyle(fontSize: 25.0, color: Colors.white)),
                    onPressed: () => check(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    // style: regular16pt.copyWith(color: textGrey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  new AddCustomer(_lihatData)));
                    },
                    child: Text(
                      'Register',
                      // style: regular16pt.copyWith(color: primaryBlue),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
        break;
      case LoginStatus.signUser:
        return DashboardUser(signOut);
        break;
      case LoginStatus.signDokter:
        return DashboardDokter(signOut);
        break;
      case LoginStatus.signIn:
        return DashboardPage(signOut);
        break;
    }
  }
}
