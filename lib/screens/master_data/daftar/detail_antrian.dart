import 'dart:convert';
import 'dart:io';
import 'package:sifaras/models/dokter_model.dart';
import 'package:sifaras/screens/master_data/daftar/list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import '../../../api/api.dart';
import '../../../models/daftarBerobat_model.dart';
import '../../../models/poli_model.dart';
import 'package:sifaras/custom/datePicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class DetailAntrianDokter extends StatefulWidget {
  final VoidCallback reload;
  final DaftarBerobatModel model;
  DetailAntrianDokter(this.model, this.reload);

  @override
  _DetailAntrianDokterState createState() => _DetailAntrianDokterState();
}

class _DetailAntrianDokterState extends State<DetailAntrianDokter> {
  String? idDokter, namaPasien, diagnosa, obat, tindakan, idDaftar, pemeriksaan;
  // tanggalGabung;
  TextEditingController? txtNamaLengkap;

  final _key = new GlobalKey<FormState>();

  var value;
  String status = "", username = "", email = "", idPasien = "", nama = "";

  List? _myActivities, _tindakan;
  late String _myActivitiesResult, _tindakanResult;
  final formKey = new GlobalKey<FormState>();

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt('value');
      status = preferences.getString('status')!;
      username = preferences.getString('username')!;
      email = preferences.getString('email')!;
      idDokter = preferences.getString('id_user')!;
      nama = preferences.getString('nama_lengkap')!;
      idPasien = widget.model.idPasien!;
      namaPasien = widget.model.namaPasien;
      idDaftar = widget.model.idDaftar!;
    });
  }

  final TextEditingController _userController = new TextEditingController();

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
        _tindakanResult = _tindakan.toString();
      });
      proses();
    }
  }

  proses() async {
    try {
      var uri = Uri.parse(BaseUrl.urlUpdateDaftarBerobat);
      var request = http.MultipartRequest("POST", uri);
      request.fields['id_daftar'] = idDaftar!;
      request.fields['diagnosa'] = diagnosa!;
      request.fields['obat'] = obat!;
      request.fields['pemeriksaan'] = pemeriksaan!;
      request.fields['tindakan'] = tindakan!;

      print("beroat :$tanggalBerobat");

      var response = await request.send();

      if (response.statusCode > 2) {
        if (this.mounted) {
          setState(() {
            widget.reload();
            Navigator.pop(context);
          });
        }
      } else {
        print("Data Gagal Ditambahkan");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String? pilihTanggal, labelText;
  DateTime tanggalBerobat = new DateTime.now();
  DateTime tanggalAkhir = new DateTime.now();

  final TextStyle valueStyle = TextStyle(fontSize: 16.0);

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: tanggalBerobat,
        firstDate: DateTime(1972),
        lastDate: DateTime(2099));
    if (picked != null && picked != tanggalBerobat) {
      setState(() {
        tanggalBerobat = picked;
        pilihTanggal = new DateFormat.yMd().format(tanggalBerobat);
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    getPref();
    _myActivities = [];
    _myActivitiesResult = '';
    _tindakan = [];
    _tindakanResult = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              'Daftar Berobat ' + namaPasien! + " id daftar: " + idDaftar!,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: Form(
            key: _key,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                // padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.amber[100],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('nama'), Text(namaPasien!)],
                            )),
                            Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('keluhan'),
                                Text(widget.model.keluhan!),
                              ],
                            )),
                          ])),
                  Container(
                    // alignment: Alignment.topLeft,
                    // padding: EdgeInsets.all(1),
                    child: MultiSelectFormField(
                      autovalidate: AutovalidateMode.disabled,
                      chipBackGroundColor: Colors.blue,
                      chipLabelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                      checkBoxActiveColor: Colors.blue,
                      checkBoxCheckColor: Colors.white,
                      dialogShapeBorder: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      title: Text(
                        "Pemeriksaan Dokter",
                        style: TextStyle(fontSize: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.length == 0) {
                          return 'Please select one or more options';
                        }
                        return null;
                      },
                      dataSource: const [
                        {
                          "display": "Demam",
                          "value": "Demam",
                        },
                        {
                          "display": "Batuk",
                          "value": "Batuk",
                        },
                        {
                          "display": "Pilek",
                          "value": "Pilek",
                        },
                        {
                          "display": "Sakit Tenggorokan",
                          "value": "Sakit Tenggorokan",
                        },
                        {
                          "display": "Lemas",
                          "value": "Lemas",
                        },
                        {
                          "display": "Pusing",
                          "value": "Pusing",
                        },
                        {
                          "display": "Diare",
                          "value": "Diare",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                      okButtonLabel: 'OK',
                      cancelButtonLabel: 'CANCEL',
                      hintWidget: Text('Please choose one or more'),
                      initialValue: _myActivities,
                      onSaved: (value) {
                        if (value == null) return;
                        setState(() {
                          _myActivities = value;
                        });
                        _myActivitiesResult = _myActivities.toString();
                      },
                    ),
                  ),
                  TextFormField(
                    controller:
                        TextEditingController(text: _myActivitiesResult),
                    // initialValue: _myActivitiesResult,
                    validator: (e) {
                      if ((e as dynamic).isEmpty) {
                        return "Silahkan tambah pemeriksaan";
                      }
                    },
                    onSaved: (e) => pemeriksaan = e,
                    decoration:
                        InputDecoration(labelText: "Tambah Pemeriksaan Lain"),
                  ),
                  TextFormField(
                    validator: (e) {
                      if ((e as dynamic).isEmpty) {
                        return "Silahkan isi diagnosa";
                      }
                    },
                    onSaved: (e) => diagnosa = e,
                    decoration: InputDecoration(labelText: "Diagnosa"),
                  ),
                  Container(
                    // alignment: Alignment.topLeft,
                    // padding: EdgeInsets.all(1),
                    child: MultiSelectFormField(
                      autovalidate: AutovalidateMode.disabled,
                      chipBackGroundColor: Colors.blue,
                      chipLabelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                      checkBoxActiveColor: Colors.blue,
                      checkBoxCheckColor: Colors.white,
                      dialogShapeBorder: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      title: Text(
                        "Tindakan Dokter",
                        style: TextStyle(fontSize: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.length == 0) {
                          return 'Please select one or more options';
                        }
                        return null;
                      },
                      dataSource: const [
                        {
                          "display": "Rawat Jalan",
                          "value": "Rawat Jalan",
                        },
                        {
                          "display": "Rawat Inap",
                          "value": "Rawat Inap",
                        },
                        {
                          "display": "UGD",
                          "value": "UGD",
                        },
                        {
                          "display": "Operasi",
                          "value": "Operasi",
                        },
                        {
                          "display": "Rujuk RS lain",
                          "value": "Rujuk RS lain",
                        },
                        {
                          "display": "Pemberian Obat",
                          "value": "Pemberian Obat",
                        },
                        {
                          "display": "Opname",
                          "value": "Opname",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                      okButtonLabel: 'OK',
                      cancelButtonLabel: 'CANCEL',
                      hintWidget: Text('Please choose one or more'),
                      initialValue: _tindakan,
                      onSaved: (value) {
                        if (value == null) return;
                        setState(() {
                          _tindakan = value;
                        });
                        _tindakanResult = _tindakan.toString();
                      },
                    ),
                  ),
                  TextFormField(
                    controller: TextEditingController(text: _tindakanResult),
                    // initialValue: _myActivitiesResult,
                    validator: (e) {
                      if ((e as dynamic).isEmpty) {
                        return "Silahkan tambah tindakan";
                      }
                    },
                    onSaved: (e) => tindakan = e,
                    decoration:
                        InputDecoration(labelText: "Tambah Tindakan Lain"),
                  ),
                  TextFormField(
                    validator: (e) {
                      if ((e as dynamic).isEmpty) {
                        return "Silahkan isi obat";
                      }
                    },
                    onSaved: (e) => obat = e,
                    decoration: InputDecoration(labelText: "Obat"),
                  ),
                  Center(
                    child: Container(
                      // alignment: Alignment.center,
                      // color: Colors.blue,
                      width: double.infinity,
                      child: MaterialButton(
                        padding: EdgeInsets.all(25.0),
                        color: Colors.green[500],
                        onPressed: () => check(),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
