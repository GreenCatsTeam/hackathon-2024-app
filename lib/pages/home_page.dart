import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/ReportPage.dart';
import 'package:flutter_application_2/pages/UserInfoPage.dart';
import 'package:flutter_application_2/pages/map_screen.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _current_page = 0;
  var _pages = [
    const ReportPage(),
    const MapScreen(),
    const Text("3"),
    const UserInfoPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: Center(
        child: _pages.elementAt(_current_page)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo, color: Colors.indigo,),
            label: "Сообщить о мусоре"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: Colors.indigo),
              label: "Карта"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.indigo),
              label: "Мои заявки"
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.indigo), label: "Мой профиль")
        ],
        currentIndex: _current_page,
        fixedColor: Colors.indigo,
        onTap: (int intIndex) {
          setState(() {
            _current_page = intIndex;
          });
        },
      ),
    );
  }
}
