import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/services/auth_service.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/buttons.dart';
import 'package:epasys_app/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController passwordConfirmationController =
      TextEditingController(text: '');
  bool obscureText = true;
  bool obscureText2 = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleChangePassword() async {
      setState(() {
        isLoading = true;
      });
      if (await AuthService().changePasswordUser(
        passwordController.text,
        passwordConfirmationController.text,
        authProvider.user.token!,
      )) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Berhasil mengubah password',
        );
        passwordController.clear();
        passwordConfirmationController.clear();
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Gagal mengubah password',
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Ganti Password',
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/img_change_password.png',
              ),
              CustomFormField(
                hintText: 'Password Baru',
                obscureText: obscureText,
                controller: passwordController,
                icon: Icons.password,
                suffixIcon: Icons.visibility_off,
                suffixIcon2: Icons.visibility,
                useSuffixIcon: true,
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomFormField(
                hintText: 'Konfirmasi Password',
                obscureText: obscureText2,
                controller: passwordConfirmationController,
                icon: Icons.password,
                suffixIcon: Icons.visibility_off,
                suffixIcon2: Icons.visibility,
                useSuffixIcon: true,
                onTap: () {
                  setState(() {
                    obscureText2 = !obscureText2;
                  });
                },
              ),
              const SizedBox(
                height: 24,
              ),
              isLoading
                  ? const LoadingButton()
                  : CustomButton(
                      title: 'Ganti Password',
                      width: double.infinity,
                      color: blueColor,
                      onPressed: handleChangePassword,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
