import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // ใช้สำหรับจัดการรูปแบบวันที่และเวลา

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentWaterAmount = 0; // ปริมาณน้ำปัจจุบัน เริ่มที่ 0 ml
  int goalAmount = 2000; // เป้าหมายการดื่มน้ำ
  List<String> drinkHistory = []; // รายการประวัติการดื่มน้ำ

  // ฟังก์ชันที่ใช้เพิ่มน้ำและตรวจสอบเป้าหมาย
  void addWater(int amount) {
    setState(() {
      currentWaterAmount += amount;

      // เพิ่มประวัติการดื่มน้ำพร้อมเวลาปัจจุบัน
      String currentTime = DateFormat('HH:mm').format(DateTime.now());
      drinkHistory.add('$currentTime - $amount ml');

      // ตรวจสอบถ้าถึงเป้าหมายแล้วรีเซ็ตใหม่
      if (currentWaterAmount >= goalAmount) {
        currentWaterAmount = 0; // รีเซ็ตปริมาณน้ำกลับไปเป็น 0
        showGoalReachedDialog(); // แสดงการแจ้งเตือนเมื่อถึงเป้าหมาย
        drinkHistory
            .add('--- Reached Goal ---'); // เพิ่มบันทึกว่าถึงเป้าหมายแล้ว
      }
    });
  }

  // ฟังก์ชันสำหรับรีเซ็ตข้อมูลทั้งหมด
  void resetData() {
    setState(() {
      currentWaterAmount = 0; // รีเซ็ตปริมาณน้ำกลับเป็น 0
      drinkHistory.clear(); // ล้างประวัติทั้งหมด
    });
  }

  // แสดงการแจ้งเตือนเมื่อถึงเป้าหมาย
  void showGoalReachedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Goal Reached!'),
          content: Text('You have reached your daily water goal. Great job!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water'),
        backgroundColor: Color(0xFF62B6F7),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // วงกลมสีฟ้าครอบข้อความ
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF62B6F7), Color(0xFFDCF4FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$currentWaterAmount", // แสดงค่าปริมาณน้ำปัจจุบัน
                        style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 8, 78)),
                      ),
                      Text(
                        "goals $goalAmount ml",
                        style: TextStyle(
                          fontSize: 24,
                          color: const Color.fromARGB(255, 0, 8, 78),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    addWater(100); // เพิ่ม 100 ml ทุกครั้งที่กดปุ่ม
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFF62B6F7),
                  ),
                  child: Text(
                    '100 ml +',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // ปุ่มรีเซ็ต
                ElevatedButton(
                  onPressed: () {
                    resetData(); // รีเซ็ตข้อมูลเมื่อกดปุ่ม
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color.fromARGB(255, 1, 14, 88)),
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFDCF4FF),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: drinkHistory.length,
                itemBuilder: (context, index) {
                  return DrinkLogItem(
                    time: drinkHistory[index].split(' - ')[0],
                    amount: drinkHistory[index].split(' - ').length > 1
                        ? drinkHistory[index].split(' - ')[1]
                        : '', // กรณีถึงเป้าหมายจะไม่มีค่า ml
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
        ],
        selectedItemColor: Color(0xFF62B6F7),
      ),
    );
  }
}

class DrinkLogItem extends StatelessWidget {
  final String time;
  final String amount;

  DrinkLogItem({required this.time, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
