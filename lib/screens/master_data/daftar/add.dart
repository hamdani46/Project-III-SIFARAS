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
import '../../../models/poli_model.dart';
import 'package:sifaras/custom/datePicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class AddDaftarBerobat extends StatefulWidget {
  final VoidCallback reload;
  AddDaftarBerobat(this.reload);

  @override
  _AddDaftarBerobatState createState() => _AddDaftarBerobatState();
}

class _AddDaftarBerobatState extends State<AddDaftarBerobat> {
  String? keluhan, idPoli, idDokter, idPoli2;
  // tanggalGabung;
  final _key = new GlobalKey<FormState>();

  var value;
  String status = "", username = "", email = "", idPasien = "", nama = "";

  List? _myActivities;
  late String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt('value');
      status = preferences.getString('status')!;
      username = preferences.getString('username')!;
      email = preferences.getString('email')!;
      idPasien = preferences.getString('id_user')!;
      nama = preferences.getString('nama_lengkap')!;
    });
  }

  final TextEditingController _userController = new TextEditingController();

  PoliModel? _currentPoli;
  final String? linkPoli = BaseUrl.urlListPoli;

  Future<List<PoliModel>> _fetchPoli() async {
    var response = await http.get(Uri.parse(linkPoli.toString()));
    print('hasilnya:' + response.statusCode.toString());
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<PoliModel> listOfPoli = items.map<PoliModel>((json) {
        return PoliModel.fromJson(json);
      }).toList();
      return listOfPoli;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  DokterModel? _currentDokter;
  final String? linkDokter = BaseUrl.urlListDokterdaftar;

  Future<List<DokterModel>> _fetchDokter() async {
    if (idPoli == null) {
      idPoli2 = "kosong";
    } else {
      idPoli2 = idPoli;
    }
    ;
    var response = await http
        .post(Uri.parse(linkDokter.toString()), body: {"id_poli": idPoli2});

    print('hasilnya:' + response.statusCode.toString());
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<DokterModel> listOfDokter = items.map<DokterModel>((json) {
        return DokterModel.fromJson(json);
      }).toList();
      return listOfDokter;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
      proses();
    }
  }

  proses() async {
    try {
      var uri = Uri.parse(BaseUrl.urlTambahDaftarBerobat);
      var request = http.MultipartRequest("POST", uri);
      request.fields['tanggal'] = "$tanggalBerobat";
      request.fields['id_pasien'] = idPasien;
      request.fields['id_poli'] = idPoli!;
      request.fields['id_dokter'] = idDokter!;
      request.fields['keluhan'] = keluhan!;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
        appBar: AppBar(
            backgroundColor: Colors.blue[500],
            title: Text(
              'Daftar Berobat $nama id: $idPasien',
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
                  Text("Tanggal Berobat"),
                  DateDropDown(
                    labelText: labelText,
                    valueText: new DateFormat("d MMM y").format(tanggalBerobat),
                    valueStyle: valueStyle,
                    onPressed: () {
                      _selectedDate(context);
                    },
                  ),
                  Text("Daftar Poli"),
                  FutureBuilder<List<PoliModel>>(
                      future: _fetchPoli(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PoliModel>> snapshot) {
                        if (!snapshot.hasData)
                          return CircularProgressIndicator();
                        return DropdownButton<PoliModel>(
                          items: snapshot.data!
                              .map((listPoli) => DropdownMenuItem<PoliModel>(
                                    child: Text(listPoli.namaPoli.toString()),
                                    value: listPoli,
                                  ))
                              .toList(),
                          onChanged: (PoliModel? value) {
                            setState(() {
                              _currentPoli = value;
                              idPoli = _currentPoli!.idPoli;
                            });
                          },
                          isExpanded: false,
                          hint: Text(idPoli == null
                              ? "pilih poli"
                              : _currentPoli!.namaPoli.toString()),
                        );
                      }),
                  Text("Daftar Dokter $idPoli"),
                  FutureBuilder<List<DokterModel>>(
                      future: _fetchDokter(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<DokterModel>> snapshot) {
                        if (!snapshot.hasData)
                          return CircularProgressIndicator();
                        return DropdownButton<DokterModel>(
                          items: snapshot.data!
                              .map((listDokter) =>
                                  DropdownMenuItem<DokterModel>(
                                    child:
                                        Text(listDokter.namaLengkap.toString()),
                                    value: listDokter,
                                  ))
                              .toList(),
                          onChanged: (DokterModel? value) {
                            setState(() {
                              _currentDokter = value;
                              idDokter = _currentDokter!.idUser;
                            });
                          },
                          isExpanded: false,
                          hint: Text(idPoli2 == "kosong"
                              ? "pilih Poli dulu"
                              : idDokter == null
                                  ? "Pilih Dokter "
                                  : _currentDokter!.namaLengkap.toString()),
                          // disabledHint: Text("Pilih Poli Terlebih Dahulu"),
                        );
                      }),
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
                        "Keluhan yang dialami",
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
                        return "Silahkan tambah keluhan anda";
                      }
                    },
                    onSaved: (e) => keluhan = e,
                    decoration:
                        InputDecoration(labelText: "Tambah Keluhan Lain"),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(16),
                  //   child: Text(_myActivitiesResult),
                  // ),
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
