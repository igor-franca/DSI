import 'package:flutter/material.dart';
import 'line.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class List extends StatefulWidget {
  const List({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListState();
}

class _ListState extends State<List>{
  Stream<QuerySnapshot<Map<String, dynamic>>> get names =>
      FirebaseFirestore.instance
          .collection('names').snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return list(context);
  }

  Widget list(context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('names').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return const Text('Carregando...');
          {
          return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemExtent: 80.0,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) =>
                  Line(
                    id: snapshot.data.docs[index]['id'],
                    favorite: snapshot.data.docs[index]['favorite'],
                    firstName: snapshot.data.docs[index]['firstName'],
                    secondName: snapshot.data.docs[index]['secondName'],)
          );
          }
        }
    );
  }
}