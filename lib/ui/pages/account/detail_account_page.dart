import 'package:epasys_app/models/user_model.dart';
import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/buttons.dart';
import 'package:epasys_app/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class DetailAccountPage extends StatefulWidget {
  const DetailAccountPage({super.key});

  @override
  State<DetailAccountPage> createState() => _DetailAccountPageState();
}

class _DetailAccountPageState extends State<DetailAccountPage> {
  TextEditingController namaController = TextEditingController(text: '');
  TextEditingController deskripsiController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController alamatController = TextEditingController(text: '');
  TextEditingController noTeleponController = TextEditingController(text: '');
  TextEditingController phoneNumberController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController passwordConfirmationController =
      TextEditingController(text: '');

  bool isLoading = false;
  bool obscureText = true;
  bool obscureText2 = true;
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detail Akun',
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, value, child) => SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SizedBox(
              width: double.infinity,
              child: Consumer<AuthProvider>(
                builder: (context, value, child) => Column(
                  children: [
                    value.user.avatar != ''
                        ? Container(
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
                          )
                        : Container(
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
                          ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomFormField(
                      readOnly: true,
                      hintText: '${value.user.nama}',
                      controller: namaController,
                      icon: Icons.person,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      readOnly: true,
                      hintText: '${value.user.deskripsi}',
                      controller: deskripsiController,
                      icon: Icons.person,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      readOnly: true,
                      hintText: '${value.user.email}',
                      controller: emailController,
                      icon: Icons.email,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      readOnly: true,
                      hintText: '${value.user.alamat}',
                      controller: alamatController,
                      icon: Icons.navigation,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      readOnly: true,
                      hintText: '${value.user.noTelepon}',
                      controller: phoneNumberController,
                      icon: Icons.phone,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomButton(
                        width: 100,
                        title: 'Edit',
                        textColor: whiteColor,
                        color: greenColor,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/edit-account',
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
