// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:monitoring_energi/data/get_data.dart';
import 'package:monitoring_energi/screen/ruangan_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/date_symbol_data_local.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<GetData> data1 = <GetData>[];
  List<GetData> data2 = <GetData>[];
  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _getData1();
    _getData2();
    initializeDateFormatting();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    // data1.clear();
    // data2.clear();
  }

  void _getData1() {
    _db.child('ruangan1').onValue.listen((event) {
      data1.clear();
      setState(() {
        for (var snapshot in event.snapshot.children) {
          var values =
              Map<String, dynamic>.from(jsonDecode(jsonEncode(snapshot.value)));
          // print('data 1 =>>>>> $values');
          var rawDate =
              DateTime.fromMillisecondsSinceEpoch(values['Timestamp']);
          // var dt = DateFormat.Hms().format(rawDate);
          // print(rawDate);
          GetData result = GetData(
            id: snapshot.key!,
            timestamp: rawDate,
            //daya buat kwh dan kwh buat daya aktif, males ganti cuk
            daya: values['kwh'],
            kwh:
                values['Daya'] != null ? values['Daya'] * 0.01 : values['Daya'],
            tegR: values['teg'] != null ? values['teg'] * 0.1 : values['teg'],
            tegS:
                values['tegS'] != null ? values['tegS'] * 0.1 : values['tegS'],
            tegT:
                values['tegT'] != null ? values['tegT'] * 0.1 : values['tegT'],
            arusR: values['arus'] != null
                ? values['arus'] * 0.001
                : values['arus'],
            arusS: values['arusS'] != null
                ? values['arusS'] * 0.001
                : values['arusS'],
            arusT: values['arusT'] != null
                ? values['arusT'] * 0.001
                : values['arusT'],
          );
          data1.add(result);
        }
      });
    });
  }

  void _getData2() {
    _db.child('ruangan2').onValue.listen((event) {
      data2.clear();
      setState(() {
        for (var snapshot in event.snapshot.children) {
          var values =
              Map<String, dynamic>.from(jsonDecode(jsonEncode(snapshot.value)));
          var rawDate =
              DateTime.fromMillisecondsSinceEpoch(values['Timestamp']);
          // var dt = DateFormat.Hms().format(rawDate);
          GetData result = GetData(
            id: snapshot.key!,
            timestamp: rawDate,
            daya: values['Daya'],
            kwh: values['kwh'] != null ? values['kwh'] * 0.01 : values['kwh'],
            tegR: values['teg'] != null ? values['teg'] * 0.1 : values['teg'],
            tegS:
                values['tegS'] != null ? values['tegS'] * 0.1 : values['tegS'],
            tegT:
                values['tegT'] != null ? values['tegT'] * 0.1 : values['tegT'],
            arusR: values['arus'] != null
                ? values['arus'] * 0.001
                : values['arus'],
            arusS: values['arusS'] != null
                ? values['arusS'] * 0.001
                : values['arusS'],
            arusT: values['arusT'] != null
                ? values['arusT'] * 0.001
                : values['arusT'],
          );
          data2.add(result);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Monitoring Daya'),
          bottom: TabBar(
            controller: _controller,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(child: Text('Ruangan 1')),
              Tab(child: Text('Ruangan 2')),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.info_outline),
              tooltip: "About",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const AlertDialog(
                    title: Text(
                      "About Us",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text("Aplikasi Monitoring Daya 3 Fasa"),
                  ),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            ScreenTab(data: data1),
            ScreenTab(data: data2),
          ],
        ),
      ),
    );
  }
}
