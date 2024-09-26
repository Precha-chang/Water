import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int selectedWaterIntake = 2000;
  TimeOfDay startTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay stopTime = TimeOfDay(hour: 20, minute: 0);
  int selectedReminderInterval = 30;

  @override
  void initState() {
    super.initState();
    loadSavedSettings();
  }

  Future<void> loadSavedSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedWaterIntake = prefs.getInt('waterIntake') ?? 2000;
      startTime = TimeOfDay(
        hour: prefs.getInt('startTimeHour') ?? 8,
        minute: prefs.getInt('startTimeMinute') ?? 0,
      );
      stopTime = TimeOfDay(
        hour: prefs.getInt('stopTimeHour') ?? 20,
        minute: prefs.getInt('stopTimeMinute') ?? 0,
      );
      selectedReminderInterval = prefs.getInt('reminderInterval') ?? 30;
    });
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('waterIntake', selectedWaterIntake);
    await prefs.setInt('startTimeHour', startTime.hour);
    await prefs.setInt('startTimeMinute', startTime.minute);
    await prefs.setInt('stopTimeHour', stopTime.hour);
    await prefs.setInt('stopTimeMinute', stopTime.minute);
    await prefs.setInt('reminderInterval', selectedReminderInterval);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Your settings have been saved.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset('assets/logo.png', height: 100),
                  SizedBox(height: 30),
                  Text(
                    'Set goals',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Have had you drink water today?',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            _buildSettingCard(
              'Water intake per day?',
              '${selectedWaterIntake} ml',
              Icons.water_drop,
              () => _showWaterIntakePicker(),
            ),
            SizedBox(height: 20),
            _buildSettingCard(
              'Time',
              'Start ${startTime.format(context)} - Stop ${stopTime.format(context)}',
              Icons.access_time,
              () => _showTimePicker(),
            ),
            SizedBox(height: 20),
            _buildSettingCard(
              'Remind every',
              '$selectedReminderInterval minute',
              Icons.notifications,
              () => _showReminderIntervalPicker(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: saveSettings,
              child: Icon(Icons.check, size: 30),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                // primary: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(
      String title, String value, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 15, 12, 12)),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(icon, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  value,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showWaterIntakePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 32,
            onSelectedItemChanged: (int index) {
              setState(() {
                selectedWaterIntake = (index + 1) * 1000;
              });
            },
            children: List<Widget>.generate(9, (int index) {
              return Center(
                child: Text('${(index + 1) * 1000} ml'),
              );
            }),
          ),
        );
      },
    );
  }

  void _showTimePicker() async {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (pickedStartTime != null) {
      setState(() {
        startTime = pickedStartTime;
      });
    }

    final TimeOfDay? pickedStopTime = await showTimePicker(
      context: context,
      initialTime: stopTime,
    );
    if (pickedStopTime != null) {
      setState(() {
        stopTime = pickedStopTime;
      });
    }
  }

  

  void _showReminderIntervalPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 32,
            onSelectedItemChanged: (int index) {
              setState(() {
                selectedReminderInterval = (index + 1) * 5;
              });
            },
            children: List<Widget>.generate(12, (int index) {
              return Center(
                child: Text('${(index + 1) * 5} minute'),
              );
            }),
          ),
        );
      },
    );
  }
}
