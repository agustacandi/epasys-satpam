import 'dart:io';

import 'package:epasys_app/models/user_model.dart';
import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:epasys_app/shared/image_helper.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/buttons.dart';
import 'package:epasys_app/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_options.dart';
import 'package:quickalert/quickalert.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({
    super.key,
  });

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  File? _image;
  final _imageHelper = ImageHelper();

  TextEditingController namaController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController noTeleponController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  bool isLoading = false;
  bool obscureText = true;
  bool obscureText2 = true;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleEditProfile() async {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        barrierDismissible: false,
      );
      if (await authProvider.updateProfile(
          namaController.text,
          deskripsiController.text,
          alamatController.text,
          emailController.text,
          noTeleponController.text,
          authProvider.user.token!)) {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Berhasil memperbarui data',
          onConfirmBtnTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Gagal memperbarui data',
        );
      }
    }

    handleEditAvatar() async {
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
                            _image = File(croppedFile.path);
                          });
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.loading,
                            barrierDismissible: false,
                          );
                          if (await authProvider.updateAvatar(
                              _image, authProvider.user.token!)) {
                            Navigator.pop(context);
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Berhasil memperbarui avatar',
                                onConfirmBtnTap: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                barrierDismissible: false);
                          } else {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              text: 'Gagal memperbarui avatar',
                              onConfirmBtnTap: () {
                                Navigator.pop(context);
                              },
                              barrierDismissible: false,
                            );
                          }
                        }
                      }
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
                            _image = File(croppedFile.path);
                          });
                        }
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.loading,
                          barrierDismissible: false,
                        );
                        if (await authProvider.updateAvatar(
                            _image, authProvider.user.token!)) {
                          Navigator.pop(context);
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Berhasil memperbarui avatar',
                              onConfirmBtnTap: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              barrierDismissible: false);
                        } else {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            text: 'Gagal memperbarui avatar',
                            onConfirmBtnTap: () {
                              Navigator.pop(context);
                            },
                            barrierDismissible: false,
                          );
                        }
                      }
                    },
                    leading: const Icon(Icons.image),
                    title: const Text('Pilih dari Galeri'),
                  ),
                ],
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Akun',
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SizedBox(
            width: double.infinity,
            child: Consumer<AuthProvider>(
              builder: (context, value, child) => Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      children: [
                        value.user.avatar == ''
                            ? Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/img_profile.png',
                                    ),
                                  ),
                                ),
                              )
                            : (_image != null
                                ? FittedBox(
                                    fit: BoxFit.contain,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      foregroundImage: FileImage(_image!),
                                      radius: 66,
                                    ),
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          '${SharedConfig().imageUrl}/${value.user.avatar}',
                                        ),
                                      ),
                                    ),
                                  )),
                        GestureDetector(
                          onTap: handleEditAvatar,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: blueColor,
                                border: Border.all(
                                  color: whiteColor,
                                  width: 3,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomFormField(
                    hintText: '${value.user.nama}',
                    controller: namaController,
                    icon: Icons.person,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    hintText: '${value.user.deskripsi}',
                    controller: deskripsiController,
                    icon: Icons.person,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    hintText: '${value.user.alamat}',
                    controller: alamatController,
                    icon: Icons.navigation,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    hintText: '${value.user.email}',
                    controller: emailController,
                    icon: Icons.email,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    hintText: '${value.user.noTelepon}',
                    controller: noTeleponController,
                    icon: Icons.phone,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomButton(
                      width: 100,
                      title: 'Update',
                      textColor: whiteColor,
                      color: greenColor,
                      onPressed: handleEditProfile,
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
}
