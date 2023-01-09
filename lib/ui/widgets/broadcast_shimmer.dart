import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class BroadcastShimmer extends StatelessWidget {
  const BroadcastShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 20,
        ),
        Card(),
        SizedBox(
          height: 10,
        ),
        Card(),
        SizedBox(
          height: 10,
        ),
        Card(),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: greyColor2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
            child: Skeleton(
              width: double.infinity,
              height: 150,
              borderRadius: 0,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Skeleton(
                  width: 120,
                  height: 10,
                  borderRadius: 10,
                ),
                SizedBox(
                  height: 4,
                ),
                Skeleton(
                  width: 100,
                  height: 10,
                  borderRadius: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
