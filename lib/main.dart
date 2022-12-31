import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/providers/broadcast_provider.dart';
import 'package:epasys_app/providers/check_in_provider.dart';
import 'package:epasys_app/providers/employee_provider.dart';
import 'package:epasys_app/providers/parking_provider.dart';
import 'package:epasys_app/providers/vehicle_provider.dart';
import 'package:epasys_app/ui/pages/account/change_password_page.dart';
import 'package:epasys_app/ui/pages/account/detail_account_page.dart';
import 'package:epasys_app/ui/pages/account/edit_account_page.dart';
import 'package:epasys_app/ui/pages/main_page.dart';
import 'package:epasys_app/ui/pages/onboarding_page.dart';
import 'package:epasys_app/ui/pages/qr/scan_page.dart';
import 'package:epasys_app/ui/pages/qr/check_out_page.dart';
import 'package:epasys_app/ui/pages/qr/helm_page.dart';
import 'package:epasys_app/ui/pages/sign_in_page.dart';
import 'package:epasys_app/ui/pages/sign_up_page.dart';
import 'package:epasys_app/ui/pages/splash_page.dart';
import 'package:epasys_app/ui/pages/upload_avatar_page.dart';
import 'package:epasys_app/ui/pages/broadcast/add_broadcast_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null).then((value) => runApp(
        const Epasys(),
      ));
}

class Epasys extends StatelessWidget {
  const Epasys({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BroadcastProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EmployeeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VehicleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ParkingProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/on-boarding': (context) => const OnBoardingPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/upload-avatar': (context) => const UploadAvatarPage(),
          '/main': (context) => const MainPage(),
          '/scan': (context) => const ScanPage(),
          '/helm': (context) => const HelmPage(),
          '/check-out': (context) => const CheckOutPage(),
          '/detail-account': (context) => const DetailAccountPage(),
          '/edit-account': (context) => const EditAccountPage(),
          '/change-password': (context) => const ChangePasswordPage(),
          '/add-broadcast': (context) => const AddBroadcastPage(),
        },
      ),
    );
  }
}
