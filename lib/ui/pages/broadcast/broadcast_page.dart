import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/providers/broadcast_provider.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/widgets/broadcast_shimmer.dart';
import 'package:epasys_app/ui/widgets/home_spotlight_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BroadcastPage extends StatefulWidget {
  const BroadcastPage({Key? key}) : super(key: key);

  @override
  State<BroadcastPage> createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  bool isLoading = true;

  getBroadcast() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    await Provider.of<BroadcastProvider>(context, listen: false)
        .getBroadcastsByToken(authProvider.user.token!);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getBroadcast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'broadcast',
        backgroundColor: blueColor,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/add-broadcast',
          );
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async => getBroadcast(),
        child: Stack(
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
            Container(
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
                    'Broadcast',
                    style: whiteTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 130,
              bottom: 0,
              left: 0,
              right: 0,
              child: Consumer<BroadcastProvider>(
                builder: (context, value, child) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    color: lightBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: isLoading
                      ? const BroadcastShimmer()
                      : (value.listBroadcasts.isEmpty
                          ? Center(
                              child: Text(
                                'Anda belum mendambahkan broadcast',
                                style: blackTextStyle,
                              ),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 15,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: value.listBroadcasts.length,
                              itemBuilder: (context, index) {
                                return BroadcastCard(
                                  broadcast: value.listBroadcasts[index],
                                );
                              },
                            )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
