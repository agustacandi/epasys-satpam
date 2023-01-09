import 'package:epasys_app/models/employee_model.dart';
import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/services/auth_service.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/account_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider = Provider.of<AuthProvider>(context);
    EmployeeModel user = userProvider.user;
    handleLogOut() async {
      if (await AuthService().logout(user.token!)) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString('token');
        if (token.runtimeType != Null) {
          await prefs.remove('token');
        }
        if (!mounted) return;
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/sign-in',
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Logout failed',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  blueColor3,
                  blueColor2,
                  // blueColor2,
                  // blueColor2,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          Consumer<AuthProvider>(
            builder: (context, value, child) => Container(
              padding: const EdgeInsets.only(
                top: 60,
                left: 24,
                right: 24,
              ),
              height: 200,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Pengaturan',
                    style: whiteTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      value.user.avatar == ''
                          ? Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/img_profile.png',
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      '${SharedConfig().imageUrl}/${value.user.avatar}'),
                                ),
                              ),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.nama}',
                            style: whiteTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: bold,
                            ),
                          ),
                          Text('${user.email}',
                              style: whiteTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: semiBold,
                              )),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.logout,
                          size: 24,
                          color: whiteColor,
                        ),
                        onPressed: () {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.confirm,
                            confirmBtnText: 'Iya',
                            cancelBtnText: 'Batal',
                            title: 'Apakah anda yakin ingin keluar?',
                            onConfirmBtnTap: handleLogOut,
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 200,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                left: 24,
                top: 24,
                right: 24,
              ),
              decoration: BoxDecoration(
                color: lightBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 24,
                  ),
                  child: Column(
                    children: <Widget>[
                      AccountItemCard(
                        icon: Icons.person_outline,
                        title: 'Akun',
                        onPressed: () {
                          Navigator.pushNamed(context, '/detail-account');
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AccountItemCard(
                        icon: Icons.vpn_key_outlined,
                        title: 'Ganti Password',
                        onPressed: () {
                          Navigator.pushNamed(context, '/change-password');
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AccountItemCard(
                        icon: Icons.info_outline,
                        title: 'Tentang',
                        onPressed: () {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.info,
                            title: 'Epasys App',
                            text: 'Versi 1.0.0',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
