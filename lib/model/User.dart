import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String email;
  String uid;
  String role;
  bool desactivated;

  User({
    required this.name,
    required this.email,
    required this.uid,
    required this.role,
    required this.desactivated,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uid": uid,
        "role": role,
        "desactivated": desactivated,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'],
      uid: snapshot['uid'],
      name: snapshot['name'],
      role: snapshot['role'],
      desactivated: snapshot['desactivated'],
    );
  }
}
