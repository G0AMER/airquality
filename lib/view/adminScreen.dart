import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_srrigation/constants.dart';
import 'package:smart_srrigation/view/auth/singup_screen_admin.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _DashScreenAdminState createState() => _DashScreenAdminState();
}

class _DashScreenAdminState extends State<AdminScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> _fetchUsers() async {
    QuerySnapshot querySnapshot = await _firestore.collection('users').get();
    return querySnapshot.docs;
  }

  Future<void> _deleteUser(String uid) async {
    try {
      await _firestore.runTransaction((transaction) async {
        transaction.delete(_firestore.collection('users').doc(uid));
      });
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  Future<void> _toggleUserActivation(
      String uid, bool isCurrentlyDeactivated) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'desactivated': !isCurrentlyDeactivated // Inverser l'état actuel
      });
    } catch (e) {
      print('Error toggling user activation: $e');
    }
  }

  void _addUser() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SignUpScreenAdmin();
      },
    );

    // Après la fermeture de la fenêtre modale, mettre à jour la liste des utilisateurs
    setState(() {
      // Recalculer la liste des utilisateurs
      // Vous pouvez implémenter cette fonction pour récupérer les utilisateurs à partir de Firestore
      // et les affecter à la liste des utilisateurs ici
      _fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Lottie.asset(
              'assets/water_plant.json',
              height: 50,
              width: 50,
            ),
          ],
        ),
      ),
      backgroundColor: color4,
      body: FutureBuilder(
        future: _fetchUsers(),
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<DocumentSnapshot> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var userData = users[index].data()
                    as Map<String, dynamic>; // Spécifier le type attendu ici
                return ListTile(
                  title: Text(userData['email'] as String),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await _deleteUser(userData['uid'] as String);
                          setState(() {
                            users.removeAt(index);
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          userData['desactivated']
                              ? Icons.lock
                              : Icons.lock_open,
                          color: userData['desactivated']
                              ? Colors.red
                              : Colors.green,
                        ),
                        onPressed: () async {
                          await _toggleUserActivation(userData['uid'] as String,
                              userData['desactivated'] as bool);
                          setState(() {
                            // Actualiser la liste après la modification pour refléter le changement d'état
                            _fetchUsers();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: Stack(
        children: [
          const Positioned(
            bottom: 16.0,
            left: 40.0,
            child: FloatingActionButton(
              onPressed: _logout,
              child: Icon(Icons.logout),
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 10.0,
            child: FloatingActionButton(
              onPressed: _addUser,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _logout() async {
  try {
    await FirebaseAuth.instance.signOut();
    // Rediriger vers l'écran de connexion ou l'écran d'accueil
    // Par exemple :
    // Navigator.pushReplacementNamed(context, '/login');
  } catch (e) {
    print('Error logging out: $e');
  }
}
