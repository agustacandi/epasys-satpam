import 'package:epasys_app/ui/pages/qr/scan_qr_page.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScanQRPage(),
              ),
            );
          },
          child: const Text('Scan QR'),
        ),
      ),
    );
  }
}
