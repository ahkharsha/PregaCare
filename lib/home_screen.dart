import 'package:flutter/material.dart';
import 'package:pregacare/widgets/home/ai_chat.dart';
import 'package:pregacare/widgets/home/emergency.dart';
import 'package:pregacare/widgets/home/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Emergency',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Emergency(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Services',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Services(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'AI Chat',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                AIChat(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
