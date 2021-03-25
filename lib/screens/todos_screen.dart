import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO一覧'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('todos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          if (snapshot.data.docs.length == 0) {
            return Text("No Data");
          }

          return ListView(
            children: snapshot.data.docs.map(
              (DocumentSnapshot document) {
                return ListTile(
                  title: Text(
                    document.data()['title'],
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
