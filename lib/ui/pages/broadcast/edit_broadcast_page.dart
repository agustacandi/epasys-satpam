import 'dart:io';

import 'package:epasys_app/models/broadcast_model.dart';
import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/providers/broadcast_provider.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:epasys_app/shared/image_helper.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class EditBroadcastPage extends StatefulWidget {
  final BroadcastModel broadcast;
  const EditBroadcastPage({super.key, required this.broadcast});

  @override
  State<EditBroadcastPage> createState() => _EditBroadcastPageState();
}

class _EditBroadcastPageState extends State<EditBroadcastPage> {
  TextEditingController judulController = TextEditingController(text: '');
  TextEditingController bodyController = TextEditingController(text: '');
  File? _foto;
  final _imageHelper = ImageHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Edit Broadcast',
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
                controller: judulController,
                style: blackTextStyle,
                decoration: InputDecoration(
                  labelText: 'Judul Broadcast',
                  hintText: widget.broadcast.judul,
                  labelStyle: blackTextStyle,
                  prefixIcon: const Icon(
                    Icons.title,
                    size: 34,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: bodyController,
                style: blackTextStyle,
                decoration: InputDecoration(
                  labelText: 'Isi Broadcast',
                  hintText: widget.broadcast.body,
                  labelStyle: blackTextStyle,
                  prefixIcon: const Icon(
                    Icons.description,
                    size: 34,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Foto Broadcast',
                style: blackTextStyle,
              ),
              GestureDetector(
                onTap: () async {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () async {
                                  final files = await _imageHelper.pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 50,
                                  );
                                  if (files.isNotEmpty) {
                                    final croppedFile = await _imageHelper.crop(
                                      file: files.first!,
                                      cropStyle: CropStyle.rectangle,
                                    );

                                    if (croppedFile != null) {
                                      setState(() {
                                        _foto = File(croppedFile.path);
                                      });
                                    }
                                  }
                                  Navigator.pop(context);
                                },
                                leading: const Icon(Icons.camera_alt),
                                title: const Text('Ambil Foto'),
                              ),
                              ListTile(
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
                                        _foto = File(croppedFile.path);
                                      });
                                    }
                                  }
                                  Navigator.pop(context);
                                },
                                leading: const Icon(Icons.image),
                                title: const Text('Pilih dari Galeri'),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: _foto != null
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
                            image: FileImage(_foto!),
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
                                '${SharedConfig().imageUrl}/${widget.broadcast.imgUrl}'),
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                title: 'Update',
                color: blueColor2,
                onPressed: () async {
                  BroadcastProvider broadcastProvider =
                      Provider.of<BroadcastProvider>(context, listen: false);
                  AuthProvider authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.loading,
                    barrierDismissible: false,
                  );
                  if (await broadcastProvider.editBroadcast(
                    widget.broadcast.id!.toString(),
                    judulController.text,
                    bodyController.text,
                    _foto,
                    authProvider.user.token!,
                  )) {
                    Navigator.pop(context);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      text: 'Berhasil mengubah broadcast',
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
                      text: 'Gagal mengubah broadcast',
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
