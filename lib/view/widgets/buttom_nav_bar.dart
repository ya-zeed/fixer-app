import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ButtomNavBar extends StatelessWidget {
  const ButtomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GNav(tabs: [
      GButton(
        icon: Icons.home,
        text: 'Home',
      )
    ]);
  }
}
