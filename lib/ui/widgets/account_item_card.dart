import 'package:epasys_app/shared/theme.dart';
import 'package:flutter/material.dart';

class AccountItemCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  const AccountItemCard({
    required this.title,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          10,
        ),
        border: Border.all(
          color: greyColor2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: blackColor,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 24,
              color: blackColor,
            ),
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
