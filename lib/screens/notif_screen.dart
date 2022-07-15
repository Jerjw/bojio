import 'package:flutter/material.dart';

class NotifsScreen extends StatefulWidget {
  const NotifsScreen({Key? key}) : super(key: key);

  @override
  _NotifsScreenState createState() => _NotifsScreenState();
}

class _NotifsScreenState extends State<NotifsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Notifs', style: TextStyle(fontSize: 60))),
    );
  }

}
