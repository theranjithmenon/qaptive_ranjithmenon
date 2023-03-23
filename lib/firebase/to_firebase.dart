import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ToFirebase {
  final user = FirebaseAuth.instance.currentUser!;
  addLocation(lat, long) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.email.toString())
        .set({'lat': lat, 'long': long});
  }
}
