import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              blueColor3,
              blueColor2,
              // blueColor2,
              // blueColor2,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            headerSection(),
            Container(
              decoration: BoxDecoration(
                color: lightBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                // physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                children: <Widget>[
                  spotlightSection(),
                  otherMenusSection(),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Skeleton(
                          width: 100,
                          height: 20,
                          borderRadius: 10,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Skeleton(
                          width: double.infinity,
                          height: 50,
                          borderRadius: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget headerSection() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 70,
        right: 16,
        bottom: 50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Skeleton(
                width: 100,
                height: 20,
                borderRadius: 10,
              ),
              const SizedBox(
                height: 6,
              ),
              Skeleton(
                width: 100,
                height: 20,
                borderRadius: 10,
              )
            ],
          ),
          Skeleton(
            width: 60,
            height: 60,
            borderRadius: 60,
          ),
        ],
      ),
    );
  }

  Widget spotlightSection() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(
                width: 16,
              ),
              Skeleton(
                width: 100,
                height: 20,
                borderRadius: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Container(
                  width: 200,
                  height: 172,
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
                      Skeleton(
                        width: 200,
                        height: 108,
                        borderRadius: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Skeleton(
                          width: 100,
                          height: 20,
                          borderRadius: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  width: 200,
                  height: 172,
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
                      Skeleton(
                        width: 200,
                        height: 108,
                        borderRadius: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Skeleton(
                          width: 100,
                          height: 20,
                          borderRadius: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  width: 200,
                  height: 172,
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
                      Skeleton(
                        width: 200,
                        height: 108,
                        borderRadius: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Skeleton(
                          width: 100,
                          height: 20,
                          borderRadius: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget otherMenusSection() {
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        top: 30,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Skeleton(
            width: 100,
            height: 20,
            borderRadius: 10,
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: greyColor2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Skeleton(
                  width: 150,
                  height: 150,
                  borderRadius: 150,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Skeleton(
                      width: 100,
                      height: 20,
                      borderRadius: 10,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Skeleton(
                      width: 100,
                      height: 20,
                      borderRadius: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
