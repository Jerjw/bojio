import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bojio/screens/chat_screen.dart';
import 'package:bojio/screens/notif_screen.dart';
//import 'package:bojio/screens/post_screen.dart';
import 'package:bojio/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:bojio/screens/detail_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late DocumentSnapshot post;
  final Stream<QuerySnapshot> events =
      FirebaseFirestore.instance.collection('events').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 630,
              width: 800,
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: events,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot,
                  ) {
                    if (snapshot.hasError) {
                      return const Text('Soething went wrong.');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading');
                    }
                    final data = snapshot.requireData;

                    return ListView.builder(
                      //itemCount: 10,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                          post: data.docs[index],
                                        ))),
                            leading: const FlutterLogo(size: 100.0), // Image
                            title:
                                Text('${data.docs[index]['title']}'), // Title
                            subtitle: Text(
                                '${data.docs[index]['description']}'), // Description
                            trailing: const Icon(Icons.favorite),
                            isThreeLine: true,
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
