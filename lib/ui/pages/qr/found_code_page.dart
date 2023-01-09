import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/providers/parking_provider.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class FoundCodePage extends StatefulWidget {
  final Function() screenClosed;
  const FoundCodePage({
    required this.screenClosed,
    super.key,
  });

  @override
  State<FoundCodePage> createState() => _FoundCodePageState();
}

class _FoundCodePageState extends State<FoundCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Data Ditemukan',
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<ParkingProvider>(
          builder: (context, value, child) => Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: greyColor,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: greyColor,
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: NetworkImage(
                          '${SharedConfig().imageUrl}/${value.confirm.user!.avatar}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  value.confirm.user!.nama!,
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  value.confirm.user!.nim!,
                  style: greyTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      height: 180,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: greyColor,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.catching_pokemon,
                            color: blueColor,
                            size: 50,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Jumlah Helm',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            value.confirm.helm.toString(),
                            style: greyTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 180,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: greyColor,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.motorcycle_outlined,
                            color: blueColor,
                            size: 50,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Nomor Polisi',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            value.confirm.vehicle!.noPolisi!,
                            style: greyTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Foto Kendaraan',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: greyColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: greyColor,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          '${SharedConfig().imageUrl}/${value.confirm.vehicle!.fotoKendaraan}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Foto STNK',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: greyColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: greyColor,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          '${SharedConfig().imageUrl}/${value.confirm.vehicle!.fotoStnk}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      title: 'Batalkan',
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      color: Colors.red,
                    ),
                    CustomButton(
                      title: 'Verifikasi',
                      onPressed: () async {
                        AuthProvider authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        ParkingProvider parkingProvider =
                            Provider.of<ParkingProvider>(context,
                                listen: false);
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.loading,
                        );
                        if (await parkingProvider.confirmParking(
                            value.confirm.nomorParkir!,
                            authProvider.user.token!)) {
                          Navigator.pop(context);
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            text: 'Berhasil Verifikasi',
                            onConfirmBtnTap: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );
                        } else {
                          Navigator.pop(context);
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            text: 'Gagal Verifikasi',
                            onConfirmBtnTap: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );
                        }
                      },
                      color: blueColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
