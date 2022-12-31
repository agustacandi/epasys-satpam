import 'package:barcode_widget/barcode_widget.dart';
import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/providers/parking_provider.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  bool isLoading = false;
  var qr;
  getCheckOut() async {
    setState(() {
      isLoading = true;
    });
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    ParkingProvider parkingProvider =
        Provider.of<ParkingProvider>(context, listen: false);
    if (await parkingProvider.getCheckOut(authProvider.user.token!)) {
      setState(() {
        qr = parkingProvider.checkOut;
      });
    } else {
      setState(() {
        qr = null;
      });
    }

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
      body: RefreshIndicator(
        onRefresh: () async => getCheckOut(),
        child: Container(
          width: double.infinity,
          height: double.maxFinite,
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
          child: Consumer<ParkingProvider>(
            builder: (context, value, child) => ListView(
              padding: const EdgeInsets.only(
                top: 60,
                left: 60,
                right: 60,
              ),
              children: [
                Text(
                  'Scan',
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/helm',
                  ),
                  child: Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(
                        color: greyColor2,
                      ),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_scanner,
                            size: 60,
                            color: blackColor,
                          ),
                          Text(
                            'Check In',
                            style: blackTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        height: 400,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: lightBackgroundColor,
                        ),
                        child: isLoading
                            ? const Center(
                                child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator()),
                              )
                            : (qr != null
                                ? Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: greyColor2,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Tunjukan QR Code ini kepada Satpam',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              border: Border.all(
                                                color: greyColor2,
                                              ),
                                            ),
                                            child: BarcodeWidget(
                                              barcode: Barcode.qrCode(
                                                errorCorrectLevel:
                                                    BarcodeQRCorrectionLevel
                                                        .high,
                                              ),
                                              data: value.checkOut.nomorParkir!,
                                              width: 200,
                                              height: 200,
                                            ),
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
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                    ],
                                  )
                                : Center(
                                    child: Text(
                                      'Anda belum melakukan Check In',
                                      style: blackTextStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: bold,
                                      ),
                                    ),
                                  )),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(
                        color: greyColor2,
                      ),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_outlined,
                            size: 60,
                            color: blackColor,
                          ),
                          Text(
                            'Check Out',
                            style: blackTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
