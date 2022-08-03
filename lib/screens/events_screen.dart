import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bojio/screens/chat_screen.dart';
import 'package:bojio/screens/notif_screen.dart';
//import 'package:bojio/screens/post_screen.dart';
import 'package:bojio/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final Stream<QuerySnapshot> events =
      FirebaseFirestore.instance.collection('events').snapshots();

  int currentIndex = 0;
  final screens = [
    const EventsScreen(),
    ChatScreen(),
    const NotifsScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     GestureDetector(
            //         child: const Text(
            //           'Joined Events',
            //           style: TextStyle(
            //             shadows: [
            //               Shadow(color: Colors.black, offset: Offset(0, -5))
            //             ],
            //             color: Colors.transparent,
            //             decoration: TextDecoration.underline,
            //             decorationColor: Colors.blue,
            //             decorationThickness: 4,
            //             fontSize: 20,
            //           ),
            //         ),
            //         onTap: () {
            //           Navigator.of(context).pushReplacement(MaterialPageRoute(
            //               builder: (context) => const EventsScreen()));
            //         }),
            //     GestureDetector(
            //         child: const Text(
            //           'Your Post',
            //           style:
            //               TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            //         ),
            //         onTap: () {
            //           Navigator.of(context).pushReplacement(MaterialPageRoute(
            //               builder: (context) => const PostScreen()));
            //         }),
            //   ],
            // ),
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
                            onTap: () {},
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
