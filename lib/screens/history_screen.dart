import 'package:flutter/material.dart';
// import 'package:intl/main.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 255, 255, 255), // พื้นหลังสีถนอมสายตา
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // Logo ส่วนด้านบน
            Center(
              child: Column(
                children: [
                  Image.asset('assets/logo.png',
                      width: 200, height: 100), // ไอคอนน้ำ
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
                        onPressed: () {
                          setState(() {
                            selectedDate =
                                selectedDate.subtract(Duration(days: 1));
                          });
                        },
                      ),
                      Text(
                        DateFormat('d MMM yyyy')
                            .format(selectedDate), // แสดงวันที่
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                        onPressed: () {
                          setState(() {
                            selectedDate = selectedDate.add(Duration(days: 1));
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),

            // ส่วนประวัติ History
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Color.fromARGB(255, 84, 167, 236),
              child: Text(
                'History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView(
                children: _buildHistoryItems(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างรายการประวัติดื่มน้ำ
  List<Widget> _buildHistoryItems() {
    List<String> dates = [
      '1 Oct 2024',
    ];

    List<Widget> items = dates.map((date) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '2000 ml',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }).toList();

    return items;
  }
}
