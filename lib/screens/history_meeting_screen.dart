import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_app/resources/firestore_methods.dart';

class HistoryMeetingScreen extends StatelessWidget {
  const HistoryMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreMethods().meetingsHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              'Room name: ${(snapshot.data! as dynamic).docs[index]['meetingName']}',
            ),
            subtitle: Text(
              'Joined on ${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}',
            ),
          ),
        );
      },
    );
  }
}
