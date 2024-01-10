import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  const TextForm({
    Key? key,
    required this.controller,
    required this.Text,
    required this.textInputType,
    required this.obsecure,
  }) : super(key: key);
  final TextEditingController controller;
  final String Text;
  final TextInputType textInputType;
  final bool obsecure;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: const EdgeInsets.only(
          top: 2,
          left: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 7,
            ),
          ],
        ),
        child: TextField(
            controller: controller,
            keyboardType: textInputType,
            obscureText: obsecure,
            decoration: InputDecoration(
                hintText: Text,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(0),
                hintStyle: const TextStyle(
                  height: 1,
                ))));
  }
}
