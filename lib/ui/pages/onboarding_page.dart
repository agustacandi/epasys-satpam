import 'package:carousel_slider/carousel_slider.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  CarouselController carouselController = CarouselController();
  List<String> title = [
    'QR Code',
    'Simpel',
    'Aman',
  ];
  List<String> description = [
    'Parkir motor jadi lebih mudah\n dengan menggunakan QR Code',
    'Tidak ribet, karena menggunakan\n smartphone.',
    'Lebih aman daripada menggunakan\n karcis parkir.',
  ];

  Future<void> getStartedButton(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding', true);
    if (!mounted) return;
    index == 2
        ? Navigator.pushNamedAndRemoveUntil(
            context,
            '/sign-in',
            (route) => false,
          )
        : carouselController.nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              CarouselSlider(
                items: [
                  Center(
                    child: Container(
                      width: 286,
                      height: 187,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/img_onboarding2.png'),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 275,
                      height: 227,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/img_onboarding3.png'),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 224,
                      height: 215,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/img_onboarding.png'),
                        ),
                      ),
                    ),
                  ),
                ],
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                carouselController: carouselController,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 30,
                  right: 25,
                  bottom: 40,
                  left: 25,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    border: Border.all(color: greyColor2)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        currentIndex == 0
                            ? Container(
                                width: 20,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: lightBlueColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              )
                            : Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                    color: greyColor, shape: BoxShape.circle),
                              ),
                        const SizedBox(
                          width: 5,
                        ),
                        currentIndex == 1
                            ? Container(
                                width: 20,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: lightBlueColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              )
                            : Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                    color: greyColor, shape: BoxShape.circle),
                              ),
                        const SizedBox(
                          width: 5,
                        ),
                        currentIndex == 2
                            ? Container(
                                width: 20,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: lightBlueColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              )
                            : Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                    color: greyColor, shape: BoxShape.circle),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      title[currentIndex],
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      description[currentIndex],
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 78,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await getStartedButton(currentIndex);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          currentIndex == 2 ? 'Mulai' : 'Selanjutnya',
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
