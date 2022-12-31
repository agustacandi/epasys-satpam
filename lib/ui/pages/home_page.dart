import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/providers/broadcast_provider.dart';
import 'package:epasys_app/providers/parking_provider.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/buttons.dart';
import 'package:epasys_app/ui/widgets/history_card.dart';
import 'package:epasys_app/ui/widgets/home_shimmer.dart';
import 'package:epasys_app/ui/widgets/home_spotlight_item.dart';
import 'package:epasys_app/ui/widgets/skeleton.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  refresh() async {
    ParkingProvider parkingProvider =
        Provider.of<ParkingProvider>(context, listen: false);
    await Provider.of<BroadcastProvider>(context, listen: false)
        .getBroadcasts();
    await parkingProvider.getParkingsToday();
    await parkingProvider.count();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const HomeShimmer()
        : Scaffold(
            backgroundColor: lightBackgroundColor,
            floatingActionButton: FloatingActionButton(
              heroTag: 'scan',
              onPressed: () {
                Navigator.pushNamed(context, '/scan');
              },
              backgroundColor: blueColor,
              child: const Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async => refresh(),
              child: SingleChildScrollView(
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
                  child: Consumer<AuthProvider>(
                    builder: (context, value, child) => Column(
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
                                child: value.user.isActive!
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Apakah Anda Selesai Bertugas?',
                                            style: blackTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          CustomButton(
                                            title: 'Saya Selesai Bertugas',
                                            color: greenColor,
                                            onPressed: () async {
                                              AuthProvider authProvider =
                                                  Provider.of<AuthProvider>(
                                                      context,
                                                      listen: false);
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.confirm,
                                                title: 'Apakah Anda Yakin?',
                                                onConfirmBtnTap: () async {
                                                  Navigator.pop(context);
                                                  QuickAlert.show(
                                                    context: context,
                                                    type:
                                                        QuickAlertType.loading,
                                                  );
                                                  if (await authProvider
                                                      .deactivateEmployee(
                                                          authProvider
                                                              .user.token!)) {
                                                    Navigator.pop(context);
                                                    QuickAlert.show(
                                                      context: context,
                                                      type: QuickAlertType
                                                          .success,
                                                      text: 'Berhasil',
                                                    );
                                                  } else {
                                                    Navigator.pop(context);
                                                    QuickAlert.show(
                                                      context: context,
                                                      type:
                                                          QuickAlertType.error,
                                                      text: 'Gagal ',
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Apakah Anda Sedang Bertugas?',
                                            style: blackTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          CustomButton(
                                            title: 'Saya Sedang Bertugas',
                                            color: greenColor,
                                            onPressed: () async {
                                              AuthProvider authProvider =
                                                  Provider.of<AuthProvider>(
                                                      context,
                                                      listen: false);
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.confirm,
                                                title: 'Apakah Anda Yakin?',
                                                onConfirmBtnTap: () async {
                                                  Navigator.pop(context);
                                                  QuickAlert.show(
                                                    context: context,
                                                    type:
                                                        QuickAlertType.loading,
                                                  );
                                                  if (await authProvider
                                                      .activateEmployee(
                                                          authProvider
                                                              .user.token!)) {
                                                    Navigator.pop(context);
                                                    QuickAlert.show(
                                                      context: context,
                                                      type: QuickAlertType
                                                          .success,
                                                      text: 'Berhasil',
                                                    );
                                                  } else {
                                                    Navigator.pop(context);
                                                    QuickAlert.show(
                                                      context: context,
                                                      type:
                                                          QuickAlertType.error,
                                                      text: 'Gagal ',
                                                    );
                                                  }
                                                },
                                              );
                                            },
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
                ),
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
      child: Consumer<AuthProvider>(
        builder: (context, value, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Selamat Datang,',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${value.user.nama}.',
                  style: whiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
            value.user.avatar == ''
                ? Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/img_profile.png',
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            '${SharedConfig().imageUrl}/${value.user.avatar}'),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget spotlightSection() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Consumer<BroadcastProvider>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Broadcast',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            value.broadcasts.isEmpty
                ? const EmptyBroadcastCard()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: value.broadcasts
                          .map(
                            (broadcast) => HomeSpotlightItem(
                              broadcast: broadcast,
                            ),
                          )
                          .toList(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget otherMenusSection() {
    return Consumer<ParkingProvider>(
      builder: (context, value, child) => Container(
        margin: const EdgeInsets.only(
          left: 16,
          top: 30,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Statistik Parkir Hari Ini',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            value.countIn == 0
                ? Container(
                    width: double.infinity,
                    height: 172,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(
                        color: greyColor2,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.motorcycle,
                            size: 34,
                            color: blackColor,
                          ),
                          Text(
                            'Belum Ada Aktivitas Parkir Hari Ini',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
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
                        AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                              sectionsSpace: 0,
                              centerSpaceRadius: 0,
                              startDegreeOffset: -90,
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sections: [
                                PieChartSectionData(
                                  color: blueColor2,
                                  value: value.countIn,
                                  radius: 80,
                                  titleStyle: whiteTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: bold,
                                  ),
                                ),
                                PieChartSectionData(
                                  color: Colors.red[300],
                                  value: value.countOut,
                                  radius: 80,
                                  titleStyle: whiteTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: blueColor2,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'Masuk',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.red[300],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'Keluar',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
