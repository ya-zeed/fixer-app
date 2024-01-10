import 'package:fixer_app/Colors/colors.dart';
import 'package:fixer_app/view/Home.dart';
import 'package:flutter/material.dart';

class button extends StatelessWidget {
  const button({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, Home.route);
        },
        child: Container(
          alignment: Alignment.center,
          height: 55,
          decoration: BoxDecoration(
            color: colors.mainColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ));
  }
}
