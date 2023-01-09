import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? onboarding = prefs.getBool('onboarding');
    final String? token = prefs.getString('token');

    if (onboarding.runtimeType != Null) {
      if (token.runtimeType != Null) {
        if (!mounted) return;
        await Provider.of<AuthProvider>(context, listen: false)
            .getCurrentUser(token!);
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/main',
          (route) => false,
        );
      } else {
        if (!mounted) return;

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/sign-in',
          (route) => false,
        );
      }
    } else {
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/on-boarding',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Center(
        child: SizedBox(
          width: 172,
          height: 48,
          child: Image.asset('assets/images/img_logo_dark.png'),
        ),
      ),
    );
  }
}
