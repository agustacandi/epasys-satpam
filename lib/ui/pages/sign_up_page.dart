import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/buttons.dart';
import 'package:epasys_app/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController deskripsiController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            headerSection(),
            const SizedBox(
              height: 120,
            ),
            footerSection(context),
          ],
        ),
      ),
    );
  }

  Widget headerSection() {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      child: Column(
        children: [
          Text(
            'Daftar Akun',
            style: blackTextStyle.copyWith(
              fontSize: 24,
              fontWeight: bold,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            'Buat akun baru untuk melanjutkan',
            style: greyTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            width: 234,
            height: 258,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_sign_up.png'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget footerSection(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSignUp() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.register(
          nameController.text,
          deskripsiController.text,
          emailController.text,
          addressController.text,
          phoneNumberController.text,
          passwordController.text,
          passwordConfirmationController.text)) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/upload-avatar', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Gagal melakukan registrasi',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    return Container(
      margin: const EdgeInsets.only(
        bottom: 70,
        left: 24,
        right: 24,
      ),
      child: Column(
        children: [
          CustomFormField(
            hintText: 'Nama Lengkap',
            controller: nameController,
            icon: Icons.person,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            hintText: 'Deskripsi',
            controller: deskripsiController,
            icon: Icons.description,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            hintText: 'Alamat',
            controller: addressController,
            icon: Icons.navigation,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            hintText: 'No Telepon (+628XXX)',
            controller: phoneNumberController,
            icon: Icons.phone,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            hintText: 'Email',
            controller: emailController,
            icon: Icons.email,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            hintText: 'Password',
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
                  title: 'Daftar',
                  width: double.infinity,
                  color: blueColor,
                  onPressed: handleSignUp,
                ),
          const SizedBox(
            height: 12,
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Kembali ke halaman Log In',
              style: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
