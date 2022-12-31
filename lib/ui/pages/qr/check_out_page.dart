import 'package:barcode_widget/barcode_widget.dart';
import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/providers/parking_provider.dart';
import 'package:epasys_app/shared/functions.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  bool isLoading = false;
  getCheckOut() async {
    setState(() {
      isLoading = true;
    });
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    await Provider.of<ParkingProvider>(context, listen: false)
        .getCheckOut(authProvider.user.token!);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getCheckOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Check Out',
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: greyColor2,
          ),
        ),
        child: Consumer<ParkingProvider>(
          builder: (context, value, child) => Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  BarcodeWidget(
                    barcode: Barcode.qrCode(
                      errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                    ),
                    data: value.checkOut.nomorParkir!,
                    width: 200,
                    height: 200,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(
                      5,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(
                        color: greyColor2,
                      ),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/ic_logo.png',
                      width: 20,
                      height: 20,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Divider(
                color: greyColor,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nomor Parkir',
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        'Nama',
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        'Jenis Kendaraan',
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        'Jam Masuk',
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        'Tanggal',
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        value.checkOut.nomorParkir!,
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        value.checkOut.user!.nama!,
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        value.checkOut.vehicle!.merek!,
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        Functions().convertDateTime3(value.checkOut.createdAt!),
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        Functions().convertDateTime2(value.checkOut.createdAt!),
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
