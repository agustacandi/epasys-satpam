import 'dart:io';

import 'package:epasys_app/models/vehicle_model.dart';
import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/providers/vehicle_provider.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:epasys_app/shared/image_helper.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class EditVehiclePage extends StatefulWidget {
  final VehicleModel vehicle;
  const EditVehiclePage({required this.vehicle, super.key});

  @override
  State<EditVehiclePage> createState() => _EditVehiclePageState();
}

class _EditVehiclePageState extends State<EditVehiclePage> {
  TextEditingController namaController = TextEditingController(text: '');
  TextEditingController merekController = TextEditingController(text: '');
  TextEditingController noPolisiController = TextEditingController(text: '');
  File? _stnk;
  File? _motor;
  final _imageHelper = ImageHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Edit Kendaraan',
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: greyColor2,
            ),
          ),
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                style: blackTextStyle,
                decoration: InputDecoration(
                  labelText: 'Nama Kendaraan',
                  hintText: widget.vehicle.nama,
                  labelStyle: blackTextStyle,
                  prefixIcon: const Icon(
                    Icons.motorcycle,
                    size: 34,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: merekController,
                style: blackTextStyle,
                decoration: InputDecoration(
                  labelText: 'Merek Kendaraan',
                  hintText: widget.vehicle.merek,
                  labelStyle: blackTextStyle,
                  prefixIcon: const Icon(
                    Icons.motorcycle,
                    size: 34,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: noPolisiController,
                style: blackTextStyle,
                decoration: InputDecoration(
                  labelText: 'Nomor Polisi',
                  hintText: widget.vehicle.noPolisi,
                  labelStyle: blackTextStyle,
                  prefixIcon: const Icon(
                    Icons.numbers,
                    size: 34,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Foto Kendaraan',
                style: blackTextStyle,
              ),
              GestureDetector(
                onTap: () async {
                  final files = await _imageHelper.pickImage(
                    imageQuality: 50,
                  );
                  if (files.isNotEmpty) {
                    final croppedFile = await _imageHelper.crop(
                      file: files.first!,
                      cropStyle: CropStyle.rectangle,
                    );

                    if (croppedFile != null) {
                      setState(() {
                        _motor = File(croppedFile.path);
                      });
                    }
                  }
                },
                child: _motor != null
                    ? Container(
                        width: double.infinity,
                        height: 200,
                        margin: const EdgeInsets.only(
                          top: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: greyColor2,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(_motor!),
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 200,
                        margin: const EdgeInsets.only(
                          top: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: greyColor2,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                '${SharedConfig().imageUrl}/${widget.vehicle.fotoKendaraan}'),
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Foto STNK',
                style: blackTextStyle,
              ),
              GestureDetector(
                onTap: () async {
                  final files = await _imageHelper.pickImage(
                    imageQuality: 50,
                  );
                  if (files.isNotEmpty) {
                    final croppedFile = await _imageHelper.crop(
                      file: files.first!,
                      cropStyle: CropStyle.rectangle,
                    );

                    if (croppedFile != null) {
                      setState(() {
                        _stnk = File(croppedFile.path);
                      });
                    }
                  }
                },
                child: _stnk != null
                    ? Container(
                        width: double.infinity,
                        height: 200,
                        margin: const EdgeInsets.only(
                          top: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: greyColor2,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(_stnk!),
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 200,
                        margin: const EdgeInsets.only(
                          top: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: greyColor2,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                '${SharedConfig().imageUrl}/${widget.vehicle.fotoStnk}'),
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                title: 'Update',
                color: greenColor,
                onPressed: () async {
                  VehicleProvider vehicleProvider =
                      Provider.of<VehicleProvider>(context, listen: false);
                  AuthProvider authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.loading,
                    barrierDismissible: false,
                  );
                  if (await vehicleProvider.editVehicle(
                      widget.vehicle.id.toString(),
                      namaController.text,
                      merekController.text,
                      noPolisiController.text,
                      _motor,
                      _stnk,
                      authProvider.user.token!)) {
                    Navigator.pop(context);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      text: 'Berhasil mengubah data kendaraan',
                      barrierDismissible: false,
                      onConfirmBtnTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
                  } else {
                    Navigator.pop(context);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      text: 'Gagal mengubah data kendaraan',
                      onConfirmBtnTap: () {
                        Navigator.pop(context);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
