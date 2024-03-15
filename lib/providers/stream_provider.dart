import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStreamProvider = StreamProvider<DocumentSnapshot>((ref) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('delivery_boys');
  return collection.snapshots().map((snapshot) => snapshot.docs.first);
});


// final dataStreamProvider = StreamProvider<List<DocumentSnapshot>>(
//   (ref) => FirebaseFirestore.instance.collection('messages').snapshots().map(
//     (snapshot) => snapshot.docs,
//   ),
// );