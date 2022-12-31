import 'package:epasys_app/shared/theme.dart';
import 'package:flutter/material.dart';

class HomeTransactionItem extends StatelessWidget {
  final String iconUrl;
  final String title;
  final String vechileName;
  final String time;

  const HomeTransactionItem({
    Key? key,
    required this.iconUrl,
    required this.title,
    required this.time,
    required this.vechileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            iconUrl,
            width: 50,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                vechileName,
                style: greyTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            time,
            style: blackTextStyle.copyWith(
              fontSize: 14,
              fontWeight: bold,
            ),
          ),
        ],
      ),
    );
  }
}
