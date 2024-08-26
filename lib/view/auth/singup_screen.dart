import 'package:smart_srrigation/constants.dart';
import 'package:smart_srrigation/view/auth/login_screen.dart';
import 'package:smart_srrigation/view/widgets/custom_button.dart';
import 'package:smart_srrigation/view/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  late SMITrigger trigFail, trigSuccess;
  late SMIBool isChecking, isHandsUp;
  late Artboard? artboard;
  late SMINumber looknum;
  late StateMachineController? stateMachineController;
  var options = [
    'Admin',
    'User',
  ];
  var _currentItemSelected = "User";
  var rool = "User";
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
    initArtBoard();
  }

  initArtBoard() {
    rootBundle.load(loginanimmationlink).then((value) {
      final file = RiveFile.import(value);
      final art = file.mainArtboard;
      stateMachineController =
          StateMachineController.fromArtboard(art, "Login Machine");
      if (stateMachineController != Null) {
        art.addController(stateMachineController!);

        for (var item in stateMachineController!.inputs) {
          print(item.name);
          if (item.name == 'isChecking') {
            isChecking = item as SMIBool;
          } else if (item.name == 'isHandsUp') {
            isHandsUp = item as SMIBool;
          } else if (item.name == 'trigFail') {
            trigFail = item as SMITrigger;
          } else if (item.name == 'trigSuccess') {
            trigSuccess = item as SMITrigger;
          } else if (item.name == 'numLook') {
            looknum = item as SMINumber;
          }
        }
      }

      setState(() {
        artboard = art;
      });
    });
  }

  void checking() {
    isChecking.change(true);
    isHandsUp.change(false);

    looknum.change(0);
  }

  void moveeyes(String value) {
    looknum.change(value.length.toDouble());
  }

  void handsup() {
    isChecking.change(false);
    isHandsUp.change(true);
  }

  void login() {
    isHandsUp.change(false);
    isChecking.change(false);
    if (_emailcontroller.text == 'k' && _passwordcontroller.text == 'k') {
      trigSuccess.fire();
    } else {
      trigFail.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 21),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 81,
                    ),
                    const Text(
                      "Air Quality\nSystem",
                      style: TextStyle(
                        fontSize: 35,
                        //fontWeight: FontWeight.w600,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    Lottie.asset('assets/plant_walk.json',
                        height: 81, width: 82),
                    //  ),
                  ],
                ),
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                if (artboard != Null)
                  SizedBox(
                    width: 240,
                    height: 240,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Rive(artboard: artboard!),
                    ),
                  ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 21),
                  child: TextField(
                    onTap: checking,
                    onChanged: ((value) => moveeyes(value)),
                    controller: _usernamecontroller,
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: const Icon(Icons.person),
                      labelStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 21),
                  child: TextField(
                    onTap: checking,
                    onChanged: ((value) => moveeyes(value)),
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      labelStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 21),
                  child: TextInputField(
                    ontap: handsup,
                    controller: _passwordcontroller,
                    labeltext: "Password",
                    icon: Icons.lock,
                    isobscure: true,
                  ),
                ),
                //210 Radio buttons for plan options
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   margin: const EdgeInsets.symmetric(horizontal: 21),
                //   child: ListTile(
                //     tileColor: _isQuantityOnlyPlan == false
                //         ? color4
                //         : const Color.fromARGB(80, 158, 158, 158),
                //     title: const Text('Quantity Only Plan'),
                //     leading: Radio(
                //       value: false,
                //       groupValue: _isQuantityOnlyPlan,
                //       onChanged: (value) {
                //         setState(() {
                //           _isQuantityOnlyPlan = value as bool;
                //         });
                //       },
                //     ),
                //   ),
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   margin: const EdgeInsets.symmetric(horizontal: 21),
                //   child: ListTile(
                //     tileColor: _isQuantityOnlyPlan == true
                //         ? color4
                //         : const Color.fromARGB(80, 158, 158, 158),
                //     title: const Text('Quantity and Quality Plan'),
                //     leading: Radio(
                //       value: true,
                //       groupValue: _isQuantityOnlyPlan,
                //       onChanged: (value) {
                //         setState(() {
                //           _isQuantityOnlyPlan = value as bool;
                //         });
                //       },
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 25,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Role : ",
                //       style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //         color: color4,
                //       ),
                //     ),
                //     DropdownButton<String>(
                //       dropdownColor: Colors.blue[900],
                //       isDense: true,
                //       isExpanded: false,
                //       iconEnabledColor: Colors.white,
                //       focusColor: Colors.white,
                //       items: options.map((String dropDownStringItem) {
                //         return DropdownMenuItem<String>(
                //           value: dropDownStringItem,
                //           child: Text(
                //             dropDownStringItem,
                //             style: TextStyle(
                //               color: color4,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 20,
                //             ),
                //           ),
                //         );
                //       }).toList(),
                //       onChanged: (newValueSelected) {
                //         setState(() {
                //           _currentItemSelected = newValueSelected!;
                //           rool = newValueSelected;
                //         });
                //       },
                //       value: _currentItemSelected,
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  title: 'Register',
                  ontap: () {
                    authController.registerUser(
                        _usernamecontroller.text,
                        _emailcontroller.text,
                        _passwordcontroller.text,
                        _currentItemSelected,
                        true);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAll(const LoginScreen());
                        // Get.offAll(LoginScreen());
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20,
                            color: color4,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
