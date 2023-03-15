import 'package:flutter/material.dart';
import 'package:flutter_application_5/listbook.dart';
import './addbook.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var app = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  );
  runApp(app);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final List<Widget> _pageWidget = <Widget>[
    AddForm(), //เรียกคลาส AddForm() จากไฟล์ addbook.dart
    // AddForm(),
    ListBook(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex), //เรียกตัวแปร _pageWidget
      //เมนูแถวล่างของจอ
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'เพิ่มข้อมูล',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'รายการหนังสือ',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, //เรียก method _onItemTapped ที่อยู่ด้านบน
      ),
    );
  }
}
