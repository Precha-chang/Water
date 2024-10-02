import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 255, 255, 255), // น้ำเงินอ่อน ถนอมสายตา
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset('assets/logo.png',
                      width: 200, height: 100), // Icon water ด้านบน
                  SizedBox(height: 10),
                  const Text(
                    'Forgot to Drink?',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0), // สีฟ้าเข้ม
                    ),
                  ),
                  SizedBox(height: 5),
                  const Text(
                    "No worries, we'll send you a notification to you!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF999999), // สีเทาอ่อน
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  timeCard('7:00 PM'),
                  timeCard('7:30 PM'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeCard(String time) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFA3D3F2), Color(0xFF5DADE2)], // ไล่สีน้ำเงิน
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.notifications, color: Colors.white, size: 35),
        title: const Text(
          'Time to Drink!!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 15, 12, 12),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          time,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
