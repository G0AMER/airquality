import 'package:flutter/material.dart';
import 'package:smart_srrigation/constants.dart';

class CustomButton extends StatelessWidget {
  void Function()? ontap;
  final String title;
  CustomButton(
      {super.key,
      this.ontap,
      required this.title,
      CircularProgressIndicator? child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 54,
      height: 50,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: linergradient,
        color: buttonColor,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 181, 181, 181),
            blurRadius: 1.5,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(200),
        ),
      ),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(200),
        ),
        color: Colors.transparent,
        // color: buttonColor,
        child: InkWell(
          onTap: ontap,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
