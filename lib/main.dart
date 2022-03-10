import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_intro/models/user.dart';
import 'package:firebase_intro/screens/wrapper.dart';
import 'package:firebase_intro/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Userr?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
    // return MaterialApp(
    //   title: 'flutter firebase intro',
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: Text("firebase"),
    //     ),
    //     floatingActionButton: FloatingActionButton(
    //       onPressed: () => FirebaseFirestore.instance
    //           .collection('testing')
    //           .add({'timestamp': Timestamp.fromDate(DateTime.now())}),
    //       child: Icon(Icons.add),
    //     ),
    //     body: StreamBuilder(
    //       stream: FirebaseFirestore.instance.collection('testing').snapshots(),
    //       builder: (
    //         BuildContext context,
    //         AsyncSnapshot<QuerySnapshot> snapshot,
    //       ) {
    //         if (!snapshot.hasData) return const SizedBox.shrink();
    //         return ListView.builder(
    //             itemCount: snapshot.data?.docs.length,
    //             itemBuilder: (BuildContext context, int index) {
    //               final docData = snapshot.data?.docs[index].data();
    //               // final dateTime = (docData['timestamp'] as Timestamp).toDate();
    //               // return ListTile(title: Text(dateTime.toString()));
    //               return ListTile(
    //                 title: Text(docData.toString()),
    //               );
    //             });
    //       },
    //     ),
    //   ),
    // );
  }
}
