import 'package:epasys_app/shared/theme.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: blackColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/images/ic_home.png',
              width: 24,
              height: 24,
            ),
          ),
          Container(
            width: 24,
            height: 24,
            color: whiteColor,
          ),
          Container(
            width: 24,
            height: 24,
            color: whiteColor,
          ),
          Container(
            width: 24,
            height: 24,
            color: whiteColor,
          ),
          Container(
            width: 24,
            height: 24,
            color: whiteColor,
          ),
        ],
      ),
    );
  }
}
