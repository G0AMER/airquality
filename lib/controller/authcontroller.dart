import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_srrigation/constants.dart';
import 'package:smart_srrigation/controller/homecontroller.dart';
import 'package:smart_srrigation/view/adminScreen.dart';
import 'package:smart_srrigation/view/auth/login_screen.dart';
import 'package:smart_srrigation/view/widgets/dashscreen.dart';

import '../model/User.dart' as model;

HomeController homecontroller = Get.find<HomeController>();

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;

  User? get user => _user.value;

  // Clés pour le stockage local
  static const String _usernameKey = 'username';
  static const String _passwordKey = 'password';

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      //Get.offAll(() => const DashScreen());
      route();
    }
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "Admin") {
          Get.offAll(() => const AdminScreen());
        } else {
          Get.offAll(() => const DashScreen());
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  // void registerUser(
  //   String username,
  //   String email,
  //   String password,
  //   bool isQuantityOnlyPlan,
  //   String role,
  // ) async {
  //   try {
  //     if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
  //       UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
  //           email: email, password: password);
  //       // Determine plan based on radio button selection
  //       String plan = isQuantityOnlyPlan
  //           ? 'Quantity and Quality Plan'
  //           : 'Quantity Only Plan';
  //       bool desactivated = true ;
  //       //  String downloadurl = await _uploadToStorage(image);
  //       model.User user = model.User(
  //         email: email,
  //         name: username,
  //         uid: cred.user!.uid,
  //         plan: plan,
  //         role: role,
  //         desactivated: desactivated,
  //       );

  //       await firestore
  //           .collection('users')
  //           .doc(cred.user!.uid)
  //           .set(user.toJson());
  //       Get.snackbar('Creating Account', 'Succefully Created your account');
  //     } else {
  //       Get.snackbar('Error Creating Account', 'Please Enter All the field');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error Creating Account', e.toString());
  //   }
  // }

  // void loginUser(String email, String password,
  //     {bool rememberPassword = false}) async {
  //   try {
  //     if (email.isNotEmpty && password.isNotEmpty) {
  //       // Authentification de l'utilisateur
  //       await firebaseAuth.signInWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );

  //       // Stockage du nom d'utilisateur et du mot de passe si "rememberPassword" est vrai
  //       if (rememberPassword) {
  //         await _storeCredentials(email, password);
  //       }
  //     } else {
  //       Get.snackbar('Error Logging in', 'Please Enter All the field');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error Logging in', e.toString());
  //   }
  // }

  void registerUser(
    String username,
    String email,
    String password,
    String role,
    bool desactivated,
  ) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        Get.offAll(const LoginScreen());
        // Determine plan based on radio button selection

        bool desactivated = true;
        //  String downloadurl = await _uploadToStorage(image);
        Get.offAll(const LoginScreen());

        model.User user = model.User(
          email: email,
          name: username,
          uid: cred.user!.uid,
          role: role,
          desactivated: desactivated,
        );
        Get.offAll(const LoginScreen());
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        Get.snackbar('Creating Account', 'Succefully Created your account');
        Get.offAll(const LoginScreen());
      } else {
        Get.snackbar('Error Creating Account', 'Please Enter All the field');
      }
    } catch (e) {
      Get.snackbar('Error Creating Account', e.toString());
    }
  }

  void loginUser(String email, String password,
      {bool rememberPassword = false}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // Authentification de l'utilisateur
        UserCredential userCredential =
            await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        //await homecontroller.fetchSystemData();
        // Récupération des données de l'utilisateur depuis Firestore
        DocumentSnapshot userSnapshot = await firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
        bool isDeactivated = userSnapshot.get('desactivated');

        if (isDeactivated == true) {
          Get.snackbar('Error Logging in',
              'Your account is deactivated. Please wait for activation by the admin.');
          // Déconnexion de l'utilisateur
          await firebaseAuth.signOut();
        } else {
          // Stockage du nom d'utilisateur et du mot de passe si "rememberPassword" est vrai
          if (rememberPassword) {
            await _storeCredentials(email, password);
          }
        }
      } else {
        Get.snackbar('Error Logging in', 'Please Enter All the fields');
      }
    } catch (e) {
      Get.snackbar('Error Logging in', e.toString());
    }
  }

  Future<void> _storeCredentials(String email, String password) async {
    // Stockage des informations d'identification dans le stockage local
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_usernameKey, email);
      prefs.setString(_passwordKey, password);
    });
  }

  // Fonction pour se souvenir du mot de passe
  Future<void> rememberPassword() async {
    // Récupérer les informations d'identification stockées localement
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString(_usernameKey);
    final savedPassword = prefs.getString(_passwordKey);

    // Connexion de l'utilisateur avec les informations d'identification sauvegardées
    if (savedUsername != null && savedPassword != null) {
      loginUser(savedUsername, savedPassword);
    } else {
      Get.snackbar('Error', 'No saved credentials found.');
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
