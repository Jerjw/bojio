import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final DocumentSnapshot post;

  DetailScreen({required this.post});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final event = FirebaseFirestore.instance.collection('events');
  final user = FirebaseAuth.instance.currentUser;
  String buttonName = 'join';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.post.get('title')),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(' '),
                const Icon(Icons.title),
                const Text(
                  ' Title: ',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Text(
                  widget.post.get('title'),
                  style: const TextStyle(
                      fontSize: 25, color: Color.fromARGB(200, 0, 0, 0)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(' '),
                const Icon(Icons.calendar_month),
                const Text(
                  ' Description: ',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Text(
                  widget.post.get('description'),
                  style: const TextStyle(
                      fontSize: 25, color: Color.fromARGB(200, 0, 0, 0)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(' '),
                const Icon(Icons.access_time),
                const Text(
                  ' Time: ',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Text(
                  widget.post.get('time'),
                  style: const TextStyle(
                      fontSize: 25, color: Color.fromARGB(200, 0, 0, 0)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(' '),
                const Icon(Icons.accessibility),
                const Text(
                  ' Date: ',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Text(
                  widget.post.get('date'),
                  style: const TextStyle(
                      fontSize: 25, color: Color.fromARGB(200, 0, 0, 0)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(' '),
                const Icon(Icons.info_outline),
                const Text(
                  ' Slot Available: ',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.get('numofpax'),
                      style: const TextStyle(
                          fontSize: 25, color: Color.fromARGB(200, 0, 0, 0)),
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(' '),
                const Icon(Icons.info_outline),
                const Text(
                  ' Participants: ',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.get('participants').toString(),
                      style: const TextStyle(
                          fontSize: 25, color: Color.fromARGB(200, 0, 0, 0)),
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.purple,
                ),
                onPressed: () {
                  final doc = event.doc(widget.post.get('title'));
                  doc.update({
                    'participants': FieldValue.arrayUnion([user?.email])
                  });
                  setState(() {
                    buttonName = "Joined";
                  });
                },
                child: Text(buttonName),
              ),
            ),
          ],
        )));
  }
}
