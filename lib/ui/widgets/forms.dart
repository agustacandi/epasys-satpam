import 'package:epasys_app/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final bool useSuffixIcon;
  final IconData? suffixIcon;
  final IconData? suffixIcon2;
  final TextEditingController? controller;
  final IconData icon;
  final VoidCallback? onTap;
  final bool readOnly;

  const CustomFormField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.useSuffixIcon = false,
    this.readOnly = false,
    this.controller,
    this.suffixIcon,
    this.suffixIcon2,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          readOnly: readOnly,
          obscureText: obscureText,
          controller: controller,
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: whiteColor,
            prefixIconColor: greyColor,
            hintStyle: greyTextStyle,
            prefixIcon: Icon(icon),
            suffixIcon: useSuffixIcon
                ? GestureDetector(
                    onTap: onTap,
                    child: obscureText ? Icon(suffixIcon2) : Icon(suffixIcon),
                  )
                : null,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            contentPadding: const EdgeInsets.all(14),
          ),
        ),
      ],
    );
  }
}
