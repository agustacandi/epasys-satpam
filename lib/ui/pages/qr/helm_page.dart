import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/providers/check_in_provider.dart';
import 'package:epasys_app/providers/vehicle_provider.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/buttons.dart';
import 'package:epasys_app/ui/widgets/vehicle_card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelmPage extends StatefulWidget {
  const HelmPage({super.key});

  @override
  State<HelmPage> createState() => _HelmPageState();
}

class _HelmPageState extends State<HelmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Pilih Helm & Kendaraan',
          style: whiteTextStyle.copyWith(fontWeight: bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(
            color: greyColor2,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Column(
          children: [
            Text(
              'Pilih Jumlah Helm',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Consumer<CheckInProvider>(
                  builder: (context, value, child) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        value.helm = 1;
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: value.helm == 1 ? blueColor2 : whiteColor,
                          border: Border.all(
                            color: value.helm == 1 ? blueColor2 : greyColor2,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '1',
                            style: TextStyle(
                                color: value.helm == 1 ? whiteColor : greyColor,
                                fontWeight: bold,
                                fontSize: 16,
                                fontFamily: 'Nunito'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Consumer<CheckInProvider>(
                  builder: (context, value, child) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        value.helm = 2;
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: value.helm == 2 ? blueColor2 : whiteColor,
                          border: Border.all(
                            color: value.helm == 2 ? blueColor2 : greyColor2,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '2',
                            style: TextStyle(
                                color: value.helm == 2 ? whiteColor : greyColor,
                                fontWeight: bold,
                                fontSize: 16,
                                fontFamily: 'Nunito'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Consumer<CheckInProvider>(
                  builder: (context, value, child) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        value.helm = 3;
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: value.helm == 3 ? blueColor2 : whiteColor,
                          border: Border.all(
                            color: value.helm == 3 ? blueColor2 : greyColor2,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                                color: value.helm == 3 ? whiteColor : greyColor,
                                fontWeight: bold,
                                fontSize: 16,
                                fontFamily: 'Nunito'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Pilih Kendaraan',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Consumer2<VehicleProvider, CheckInProvider>(
                builder: (context, value, checkIn, child) => Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: value.vehicles.length,
                    itemBuilder: (context, index) {
                      var vehicle = value.vehicles[index];
                      return GestureDetector(
                        onTap: () {
                          checkIn.idKendaraan = vehicle.id!;
                          checkIn.index = index;
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(
                              width: 2,
                              color: checkIn.index == index
                                  ? blueColor2
                                  : greyColor2,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: lightBlueColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/ic_logo.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicle.nama!,
                                    style: blackTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                  Text(
                                    '${vehicle.merek} - ${vehicle.noPolisi}',
                                    style: greyTextStyle,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                icon: Icon(
                                  checkIn.index == index ? Icons.check : null,
                                  size: 30,
                                  color: blueColor,
                                ),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              title: 'Selanjutnya',
              color: blueColor2,
              onPressed: () => Navigator.pushNamed(context, '/check-in'),
            )
          ],
        ),
      ),
    );
  }
}
