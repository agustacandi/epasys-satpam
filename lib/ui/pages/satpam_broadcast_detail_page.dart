import 'package:epasys_app/models/broadcast_model.dart';
import 'package:epasys_app/providers/auth_provider.dart';
import 'package:epasys_app/providers/broadcast_provider.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:epasys_app/shared/functions.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/pages/broadcast/edit_broadcast_page.dart';
import 'package:epasys_app/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class SatpamBroadcastDetailPage extends StatefulWidget {
  final BroadcastModel broadcast;
  const SatpamBroadcastDetailPage({
    required this.broadcast,
    super.key,
  });

  @override
  State<SatpamBroadcastDetailPage> createState() =>
      _SatpamBroadcastDetailPageState();
}

class _SatpamBroadcastDetailPageState extends State<SatpamBroadcastDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Broadcast',
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      '${SharedConfig().imageUrl}/${widget.broadcast.imgUrl}',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(
                  16,
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(
                    color: greyColor2,
                  ),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.broadcast.judul!,
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Diposting oleh Satpam ${widget.broadcast.employee!.nama} pada ${Functions().convertDateTime(widget.broadcast.createdAt!)}',
                      style: blackTextStyle,
                    ),
                    Divider(
                      color: greyColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Deskripsi',
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.broadcast.body!,
                      style: blackTextStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: greyColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          title: 'Hapus',
                          color: Colors.red,
                          onPressed: () {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              title: 'Apakah anda yakin?',
                              confirmBtnText: 'Ya',
                              cancelBtnText: 'Tidak',
                              onConfirmBtnTap: () async {
                                Navigator.pop(context);
                                BroadcastProvider vehicleProvider =
                                    Provider.of<BroadcastProvider>(context,
                                        listen: false);
                                AuthProvider authProvider =
                                    Provider.of<AuthProvider>(context,
                                        listen: false);
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.loading,
                                  barrierDismissible: false,
                                );
                                if (await vehicleProvider.deleteBroadcast(
                                    widget.broadcast.id!,
                                    authProvider.user.token!)) {
                                  Navigator.pop(context);
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    text: 'Berhasil menghapus broadcast',
                                    onConfirmBtnTap: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  );
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    text: 'Gagal menghapus broadcast',
                                  );
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomButton(
                          title: 'Edit',
                          color: greenColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBroadcastPage(
                                  broadcast: widget.broadcast,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
