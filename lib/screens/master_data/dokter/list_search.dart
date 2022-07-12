import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../models/dokter_model.dart';
import 'dart:convert';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import '../../../api/api.dart';
import 'package:sifaras/screens/master_data/dokter/edit.dart';

class SearchList extends StatefulWidget {
  SearchList() : super();

  final String title = "Cari Dokter";

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  late AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<DokterModel>> key = new GlobalKey();
  static List<DokterModel> products = <DokterModel>[];
  bool loading = true;

  getPref() async {
    getUsers();
  }

  void getUsers() async {
    try {
      final response = await http.get(Uri.parse(BaseUrl.urlListDokter));
      if (response.statusCode == 200) {
        products = loadUsers(response.body);
        print('Dokter: ${products.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting product.");
      }
    } catch (e) {
      print("Error getting data api.");
    }
  }

  static List<DokterModel> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<DokterModel>((json) => DokterModel.fromJson(json))
        .toList();
  }

  // final list = [];
  // Future<void> _lihatData() async {
  //   list.clear();
  //   setState(() {
  //     loading = true;
  //   });

  //   final response = await http.get(Uri.parse(BaseUrl.urlListDokter));

  //   if (response.contentLength == 2) {
  //     print(response);
  //   } else {
  //     print(response);
  //     final data = jsonDecode(response.body);
  //     data.forEach((api) {
  //       final ab = new DokterModel(
  //           api['id_user'],
  //           api['nama_lengkap'],
  //           api['jenis_kelamin'],
  //           api['tanggal_lahir'],
  //           api['nama_jabatan'],
  //           api['tanggal_gabung'],
  //           api['log_datetime'],
  //           api['id_jabatan']);
  //       list.add(ab);
  //     });

  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  _proseshapus(String idUser) async {
    final response = await http
        .post(Uri.parse(BaseUrl.urlHapusDokter), body: {"id_user": idUser});
    final data = jsonDecode(response.body);
    int value = data['success'];
    String pesan = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
        getUsers();
      });
    } else {
      print(pesan);
      print(idUser);
    }
  }

  dialogHapus(String idUser) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView(
              padding: EdgeInsets.all(16.0),
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  "Apakah anda yakin ingin menghapus data ini?",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 18.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Tidak",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 25.0),
                    InkWell(
                      onTap: () {
                        _proseshapus(idUser);
                      },
                      child: Text(
                        "Ya",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ]),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Widget row(DokterModel product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          product.namaLengkap!,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          "Spesialis " + product.namaJabatan!,
        ),
        IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditDokter(product, getUsers)));
            }),
        IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              dialogHapus(product.idUser.toString());
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          loading
              ? CircularProgressIndicator()
              : searchTextField = AutoCompleteTextField<DokterModel>(
                  key: key,
                  clearOnSubmit: false,
                  suggestions: products,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                    hintText: "Masukan Nama",
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  itemFilter: (item, query) {
                    return item.namaLengkap!
                        .toLowerCase()
                        .startsWith(query.toLowerCase());
                  },
                  itemSorter: (a, b) {
                    return a.namaLengkap!.compareTo(b.namaLengkap!);
                  },
                  itemSubmitted: (item) {
                    setState(() {
                      searchTextField.textField!.controller?.text =
                          item.namaLengkap!;
                    });
                  },
                  itemBuilder: (context, item) {
                    return row(item);
                  },
                )
        ],
      ),
    );
  }
}
