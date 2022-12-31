import 'package:epasys_app/models/vehicle_model.dart';
import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/pages/vehicle/detail_vehicle_page.dart';
import 'package:flutter/material.dart';

class VehicleCardItem extends StatelessWidget {
  final VehicleModel vehicle;
  const VehicleCardItem({required this.vehicle, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
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
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: lightBlueColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                'assets/images/ic_logo.png',
                width: 30,
                height: 30,
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
                vehicle.nama!,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              Text(
                '${vehicle.merek} - ${vehicle.noPolisi}',
                style: greyTextStyle,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailVehiclePage(
                    vehicle: vehicle,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
