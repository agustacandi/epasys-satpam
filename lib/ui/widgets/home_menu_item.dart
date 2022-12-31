import 'package:epasys_app/shared/theme.dart';
import 'package:flutter/material.dart';

class HomeMenuItem extends StatelessWidget {
  final String iconUrl;
  final String menuName;
  final VoidCallback onTap;

  const HomeMenuItem({
    Key? key,
    required this.iconUrl,
    required this.menuName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: greyColor2),
            ),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(iconUrl),
                ),
              ),
            ),
          ),
          Text(
            menuName,
            style: blackTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
          )
        ],
      ),
    );
  }
}
