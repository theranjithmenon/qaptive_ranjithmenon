import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qaptive_ranjithmenon/views/home/route.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(snapshot.data!.docs[index].reference.id),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RouteToUser(
                                    userLat: snapshot.data!.docs[index]['lat'],
                                    userLong: snapshot.data!.docs[index]
                                        ['long'],
                                    userEmail:
                                        snapshot.data!.docs[index].reference.id,
                                  )));
                    },
                  ));
                });
          }
        });
  }
}
