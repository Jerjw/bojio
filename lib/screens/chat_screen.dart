import 'package:bojio/screens/chat_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  var currentUser = FirebaseAuth.instance.currentUser?.uid;
  final user = FirebaseAuth.instance.currentUser;

  void callChatDetailScreen(BuildContext context, String name, String uid) {
    print("tapped on: " +  name );
    print("uid: " +  uid );
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                ChatDetail(friendUid: uid, friendName: name)));
  }

   @override
   Widget build(BuildContext context) {
     return StreamBuilder<QuerySnapshot>(
         stream: FirebaseFirestore.instance
             .collection('users')
             .where('uid', isNotEqualTo: currentUser)
             .snapshots(),
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

           if (snapshot.hasError) {
             print("error");
             return Center(
               child: Text("Something went wrong"),
             );
           }

           if (snapshot.connectionState == ConnectionState.waiting) {
             print("waiting for data");
             return Center(
               child: Text("Loading"),
             );
           }

           if (snapshot.hasData) {
            print("snapshot has data");
             return CustomScrollView(
               slivers: [
                 CupertinoSliverNavigationBar(
                   largeTitle: Text("People"),
                 ),
                 SliverList(
                   delegate: SliverChildListDelegate(
                     snapshot.data!.docs.map(
                           (DocumentSnapshot document) {

                             Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
                               return CupertinoListTile(
                                 onTap: () => callChatDetailScreen(context, data!['name'], data!['uid']),
                                 title: Text(data!['name']),
                               );
                           },
                     ).toList(),
                   ),
                 )
               ],
             );
           }

           return Container();
         });
   }
}

