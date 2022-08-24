// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final user = FirebaseAuth.instance.currentUser;

  var currentUsername = FirebaseAuth.instance.currentUser?.displayName;

  var title = '';
  var description = '';
  TextEditingController _descriptionTextController = TextEditingController();
  TextEditingController _titleTextController = TextEditingController();
  TextEditingController _numPaxTextController = TextEditingController();

  TextEditingController _date = TextEditingController();
  var date = '';

  TextEditingController _time = TextEditingController();
  var time = '';

  String buttonName = 'Submit';
  DateTime dateTime = DateTime.now();

  File? imagefile;

  Future chooseImage(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final imageTemporart = File(pickedFile.path);

    setState(() {
      imagefile = imageTemporart;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return Scaffold(
        appBar: AppBar(
          title: Text("Add Event"),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            const SizedBox(height: 30),
            const SizedBox(
              width: 300,
              child: Text(
                'Event Title',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              height: 45,
              child: TextField(
                controller: _titleTextController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Event Title",
                    labelStyle: TextStyle()),
                onChanged: (value) {
                  title = value;
                },
              ),
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 300,
              child: Text(
                'Event Description',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              height: 45,
              child: TextField(
                controller: _descriptionTextController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Event Descrption",
                    labelStyle: TextStyle()),
                onChanged: (value) {
                  description = value;
                },
              ),
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 300,
              child: Text(
                'Select Date',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              height: 45,
              child: TextField(
                controller: _date,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Select Date",
                    labelStyle: TextStyle()),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    setState(() {
                      _date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                    });
                  }
                },
                onChanged: (value) {
                  date = value;
                },
              ),
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 300,
              child: Text(
                'Select Time',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              height: 45,
              child: TextField(
                controller: _time,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Select Date",
                    labelStyle: TextStyle()),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                          hour: dateTime.hour, minute: dateTime.minute));

                  if (pickedTime != null) {
                    setState(() {
                      _time.text = '${pickedTime.hour} : ${pickedTime.minute}';
                    });
                  }
                },
                onChanged: (value) {
                  time = value;
                },
              ),
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 300,
              child: Text(
                'Number of Pax',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              height: 45,
              child: TextField(
                controller: _numPaxTextController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Number of Pax",
                    labelStyle: TextStyle()),
              ),
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 300,
              child: Text(
                'Select Image',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              child: Column(children: [
                if (imagefile != null)
                  Image.file(
                    imagefile!,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                else
                  Image.asset('assets/imageAdd.png'),
              ]),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton.icon(
                onPressed: () async {
                  chooseImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.image),
                label: const Text('Choose From Gallery'),
              ),
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
                onPressed: () async {

                  FirebaseFirestore.instance
                      .collection('events')
                      .doc(_titleTextController.text.trim())
                      .set({
                    'description': _descriptionTextController.text.trim(),
                    'title': _titleTextController.text.trim(),
                    'date': _date.text.trim(),
                    'time': _time.text.trim(),
                    'numofpax': _numPaxTextController.text.trim(),
                    'host': user!.uid.toString(),
                    'participants': [currentUsername],
                  });

                  final successMsg =
                      SnackBar(content: const Text('Event added successfully'));
                  ScaffoldMessenger.of(context).showSnackBar(successMsg);
                  Navigator.pop(context);
                },
                child: Text(buttonName),
              ),
            ),
          ],
        )));
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );
}
