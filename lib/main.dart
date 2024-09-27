import 'package:flutter/material.dart';
import 'package:water/screens/home_screen.dart';
import 'package:water/screens/message_screen.dart';
import 'package:water/screens/setting_screen.dart';
import 'package:water/screens/history_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OperaterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OperaterScreen extends StatefulWidget {
  const OperaterScreen({super.key});

  @override
  State<OperaterScreen> createState() => _OperaterScreenState();
}

class _OperaterScreenState extends State<OperaterScreen> {
  // ตัวแปรสำหรับเก็บ index ของหน้าใน PageView
  int _currentIndex = 0;

  // สร้าง list ของหน้าต่างๆ ในรูปแบบ Array
  final List<Widget> _pages = [
    HomeScreen(),
    SettingScreen(),
    HistoryScreen(),
    MessageScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // เปลี่ยนหน้าเมื่อมีการเลือก index ใหม่
    });
  }

  // ตัวควบคุม PageView
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white, // สีพื้นหลัง
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 15,
              offset: Offset(0, 3), // เพิ่มเงา
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped, // เรียกฟังก์ชันเมื่อมีการเลือกเมนู
          backgroundColor: Colors.white, // สีพื้นหลังของ BottomNavigationBar
          selectedItemColor: Colors.blueAccent, // สีของไอเท็มที่ถูกเลือก
          unselectedItemColor: const Color.fromARGB(
              255, 45, 39, 39), // สีของไอเท็มที่ไม่ได้ถูกเลือก
          showUnselectedLabels: true, // แสดง label แม้ไม่ได้เลือก
          selectedFontSize: 14.0, // ขนาดตัวหนังสือไอเท็มที่ถูกเลือก
          unselectedFontSize: 12.0, // ขนาดตัวหนังสือไอเท็มที่ไม่ได้ถูกเลือก
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  size: 30, color: Colors.black), // เพิ่มขนาดไอคอน
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 30, color: Colors.black),
              label: 'Setting',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history, size: 30, color: Colors.black),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message, size: 30, color: Colors.black),
              label: 'Message',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
