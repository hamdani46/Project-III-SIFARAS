import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'package:timeline_tile/timeline_tile.dart';
import '../../../models/daftarBerobat_model.dart';
import '../../../api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaras/custom/datePicker.dart';

class DaftarTimeLine extends StatefulWidget {
  final VoidCallback reload;
  final DaftarBerobatModel model;
  DaftarTimeLine(this.model, this.reload);

  @override
  _DaftarTimeLineState createState() => _DaftarTimeLineState();
}

class _DaftarTimeLineState extends State<DaftarTimeLine> {
  final _key = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // jenisKelamin = widget.model.jenisKelamin.toString();
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      appBar: AppBar(
          backgroundColor: Colors.blue[500],
          title: const Text(
            'Time Line Pendaftaran',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: ListView(
        children: [
          SizedBox(height: 10.0),
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Hai, " + widget.model.namaPasien!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(
                    (() {
                      if (widget.model.status == "") {
                        return "Terimakasih masih menunggu";
                      }

                      return "Terimakasih atas kunjungan anda";
                    })(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    (() {
                      if (widget.model.status == "") {
                        return "Berikut nomor antrian anda";
                      }

                      return "semoga lekas sembuh";
                    })(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100)
                      //more than 50% of width makes circle
                      ),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                          child: Text(
                            widget.model.noAntrian!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 45, // light
                              fontStyle: FontStyle.italic, // italic
                            ),
                          ),
                        ),
                        const Text(
                          "no antrian",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16, // light
                            fontStyle: FontStyle.italic, // italic
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 18.0),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100)
                      //more than 50% of width makes circle
                      ),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                          child: Text(
                            widget.model.idDaftar!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 45, // light
                              fontStyle: FontStyle.italic, // italic
                            ),
                          ),
                        ),
                        const Text(
                          "no daftar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16, // light
                            fontStyle: FontStyle.italic, // italic
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.amber[100],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.model.tanggal!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Divider(),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Nama Poli'),
                        Text(widget.model.namaPoli!),
                      ],
                    )),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Nama DOkter'),
                        Text(widget.model.namaDokter!),
                      ],
                    )),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Keluhan'),
                        Text(
                          widget.model.keluhan!,
                          // style: const TextStyle(
                          //   // color: Colors.blue,
                          //   fontSize: 20, // light
                          //   fontStyle: FontStyle.italic, // italic
                          // ),
                        ),
                      ],
                    )),
                  ])),
          SizedBox(
            child: TimelineTile(
              alignment: TimelineAlign.manual,
              endChild: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Pendaftaran",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              isFirst: true,
              beforeLineStyle: LineStyle(color: Colors.lightBlueAccent),
              afterLineStyle: LineStyle(color: Colors.lightBlueAccent),
              lineXY: 0.2,
              indicatorStyle: IndicatorStyle(
                color: Colors.green.shade600,
                width: 30,
                iconStyle: IconStyle(
                    iconData: Icons.check, color: Colors.white, fontSize: 28),
              ),
            ),
          ),
          SizedBox(
            child: TimelineTile(
              alignment: TimelineAlign.manual,
              endChild: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Pemeriksaan Dokter"),
              ),
              beforeLineStyle: LineStyle(color: Colors.lightBlueAccent),
              afterLineStyle: LineStyle(color: Colors.lightBlueAccent),
              lineXY: 0.2,
              indicatorStyle: IndicatorStyle(
                color: (widget.model.status == "")
                    ? Colors.redAccent.shade200
                    : Colors.green.shade600,
                width: 30,
                iconStyle: IconStyle(
                    iconData:
                        (widget.model.status == "") ? Icons.close : Icons.check,
                    color: Colors.white,
                    fontSize: 28),
              ),
            ),
          ),
          SizedBox(
            child: TimelineTile(
              alignment: TimelineAlign.manual,
              endChild: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Pemberian Obat"),
              ),
              beforeLineStyle: LineStyle(color: Colors.lightBlueAccent),
              afterLineStyle: LineStyle(color: Colors.lightBlueAccent),
              lineXY: 0.2,
              indicatorStyle: IndicatorStyle(
                color: (widget.model.status == "")
                    ? Colors.redAccent.shade200
                    : Colors.green.shade600,
                width: 30,
                iconStyle: IconStyle(
                    iconData:
                        (widget.model.status == "") ? Icons.close : Icons.check,
                    color: Colors.white,
                    fontSize: 28),
              ),
            ),
          ),
          SizedBox(
            child: TimelineTile(
              alignment: TimelineAlign.manual,
              endChild: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Selesai"),
              ),
              beforeLineStyle: LineStyle(color: Colors.lightBlueAccent),
              afterLineStyle: LineStyle(color: Colors.lightBlueAccent),
              lineXY: 0.2,
              isLast: true,
              indicatorStyle: IndicatorStyle(
                color: (widget.model.status == "")
                    ? Colors.redAccent.shade200
                    : Colors.green.shade600,
                width: 30,
                iconStyle: IconStyle(
                    iconData:
                        (widget.model.status == "") ? Icons.close : Icons.check,
                    color: Colors.white,
                    fontSize: 28),
              ),
            ),
          )
        ],
      ),
    );
  }
}
