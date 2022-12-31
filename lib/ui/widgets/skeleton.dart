import 'package:epasys_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart' as shmmr;

class Skeleton extends StatelessWidget {
  final double? width, height, borderRadius;

  const Skeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) => shmmr.Shimmer.fromColors(
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.grey.shade700,
        direction: shmmr.ShimmerDirection.ltr,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: greyColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
        ),
      );
}

class Shimmer extends StatelessWidget {
  const Shimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        15,
      ),
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: greyColor2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Skeleton(
            width: 60,
            height: 60,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Skeleton(
                width: 100,
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Skeleton(
                width: 140,
                height: 10,
              ),
            ],
          ),
          const Spacer(),
          const Skeleton(
            width: 30,
            height: 30,
            borderRadius: 100,
          ),
        ],
      ),
    );
  }
}

class HomeHeaderShimmer extends StatelessWidget {
  const HomeHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
        left: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Skeleton(
            width: 100,
            height: 20,
            borderRadius: 10,
          ),
          SizedBox(
            height: 12,
          ),
          Skeleton(
            width: double.infinity,
            height: 50,
            borderRadius: 50,
          ),
        ],
      ),
    );
  }
}
