import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentWaterAmount = 0;
  int goalAmount = 2000;
  int selectedWaterAmount = 100;
  List<String> drinkHistory = [];
  List<int> waterOptions = [
    50,
    100,
    150,
    200,
    250,
    300,
    400,
    500,
    600
  ]; // Options for water amount

  void addWater(int amount) {
    setState(() {
      currentWaterAmount += amount;
      String currentTime = DateFormat('HH:mm').format(DateTime.now());
      drinkHistory.insert(0, '$currentTime - $amount ml');

      if (currentWaterAmount >= goalAmount) {
        showGoalReachedDialog();
      }
    });
  }

  void resetHistory() {
    setState(() {
      drinkHistory.clear();
      currentWaterAmount = 0;
    });
  }

  void showGoalReachedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Goal Reached!'),
          content: Text('You have reached your daily water goal. Great job!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showWaterOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Water Amount'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: waterOptions.map((amount) {
              return ListTile(
                title: Text('$amount ml'),
                onTap: () {
                  setState(() {
                    selectedWaterAmount = amount;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 249, 249, 250),
                    Color.fromARGB(255, 36, 163, 247)
                  ],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Water',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$currentWaterAmount',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 10, 6, 133),
                              ),
                            ),
                            Text(
                              'goals $goalAmount ml',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: showWaterOptionsDialog,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '$selectedWaterAmount ml',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 10, 6, 133),
                                ),
                              ),
                              Icon(Icons.arrow_drop_down,
                                  color: Color.fromARGB(255, 10, 6, 133)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => addWater(selectedWaterAmount),
                        child: Text('Drinking'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color.fromARGB(255, 10, 6, 133),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Drinking History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: resetHistory,
                    child: Text('Reset History'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 36, 163, 247),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: drinkHistory.length,
                itemBuilder: (context, index) {
                  final entry = drinkHistory[index].split(' - ');
                  return ListTile(
                    leading: Icon(Icons.access_time, color: Color(0xFF7C3AED)),
                    title: Text(entry[0]),
                    trailing: Text(entry[1]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
        ],
        selectedItemColor: Color(0xFF7C3AED),
      ),
    );
  }
}
