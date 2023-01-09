import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/providers/broadcast_provider.dart';
import 'package:epasys_app/providers/parking_provider.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/buttons.dart';
import 'package:epasys_app/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  bool isLoading = false;
  bool obscureText = true;
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
              height: 150,
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
            'Selamat Datang',
            style: blackTextStyle.copyWith(
              fontSize: 24,
              fontWeight: bold,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            'Login menggunakan akun untuk melanjutkan',
            style: greyTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            width: 315,
            height: 240,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_sign_in.png'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget footerSection(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSignIn() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(
          emailController.text.toUpperCase(), passwordController.text)) {
        await Provider.of<ParkingProvider>(context, listen: false)
            .getLatestParkings(authProvider.user.token!);
        if (!mounted) return;
        await Provider.of<BroadcastProvider>(context, listen: false)
            .getBroadcasts();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', 'Bearer ${authProvider.user.token!}');
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/main',
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Email atau password salah!',
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
            hintText: 'Email',
            controller: emailController,
            icon: Icons.person,
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
            height: 24,
          ),
          isLoading
              ? const LoadingButton()
              : CustomButton(
                  title: 'Login',
                  width: double.infinity,
                  color: blueColor,
                  onPressed: handleSignIn,
                ),
          const SizedBox(
            height: 12,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sign-up');
            },
            child: Text(
              'Buat Akun Baru',
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
