import 'package:epasys_app/models/vehicle_model.dart';
import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/providers/vehicle_provider.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:epasys_app/shared/functions.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/pages/vehicle/edit_vehicle_page.dart';
import 'package:epasys_app/ui/pages/broadcast/broadcast_page.dart';
import 'package:epasys_app/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class DetailVehiclePage extends StatefulWidget {
  final VehicleModel vehicle;
  const DetailVehiclePage({required this.vehicle, super.key});

  @override
  State<DetailVehiclePage> createState() => _DetailVehiclePageState();
}

class _DetailVehiclePageState extends State<DetailVehiclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Detail Kendaraan',
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: Border.all(
                    color: greyColor2,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      '${SharedConfig().imageUrl}/${widget.vehicle.fotoKendaraan}',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: Border.all(
                    color: greyColor2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      widget.vehicle.merek!,
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: greyColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pemilik',
                              style: blackTextStyle,
                            ),
                            Text(
                              'Nama',
                              style: blackTextStyle,
                            ),
                            Text(
                              'Ditambahkan Pada',
                              style: blackTextStyle,
                            ),
                            Text(
                              'Jam',
                              style: blackTextStyle,
                            ),
                            Text(
                              'Merek',
                              style: blackTextStyle,
                            ),
                            Text(
                              'Nomor Polisi',
                              style: blackTextStyle,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.vehicle.user!.nama!,
                              style: blackTextStyle,
                            ),
                            Text(
                              widget.vehicle.nama!,
                              style: blackTextStyle,
                            ),
                            Text(
                              Functions()
                                  .convertDateTime(widget.vehicle.createdAt!),
                              style: blackTextStyle,
                            ),
                            Text(
                              Functions()
                                  .convertDateTime3(widget.vehicle.createdAt!),
                              style: blackTextStyle,
                            ),
                            Text(
                              widget.vehicle.merek!,
                              style: blackTextStyle,
                            ),
                            Text(
                              widget.vehicle.noPolisi!,
                              style: blackTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: greyColor,
                    ),
                    Text(
                      'Foto STNK',
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: greyColor2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              '${SharedConfig().imageUrl}/${widget.vehicle.fotoStnk}'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: greyColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          title: 'Hapus',
                          color: Colors.red[400],
                          textColor: whiteColor,
                          onPressed: () {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              title: 'Apakah anda yakin?',
                              confirmBtnText: 'Ya',
                              cancelBtnText: 'Tidak',
                              onConfirmBtnTap: () async {
                                Navigator.pop(context);
                                VehicleProvider vehicleProvider =
                                    Provider.of<VehicleProvider>(context,
                                        listen: false);
                                AuthProvider authProvider =
                                    Provider.of<AuthProvider>(context,
                                        listen: false);
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.loading,
                                  barrierDismissible: false,
                                );
                                if (await vehicleProvider.deleteVehicle(
                                    widget.vehicle.id!,
                                    authProvider.user.token!)) {
                                  Navigator.pop(context);
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    text: 'Berhasil menghapus kendaraan',
                                    onConfirmBtnTap: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  );
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    text: 'Gagal menghapus kendaraan',
                                  );
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomButton(
                          title: 'Edit',
                          color: greenColor,
                          textColor: whiteColor,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditVehiclePage(
                                vehicle: widget.vehicle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
