import 'package:canary_app/core/extensions/extensions.dart';
import 'package:canary_app/presentation/buyer/home/buyer_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:canary_app/data/model/response/buyer/buyer_profile_response_model.dart';


class ProfileViewBuyer extends StatelessWidget {
  final Data profile;
  const ProfileViewBuyer({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nama: ${profile.name}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Nama: ${profile.address}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Nama: ${profile.phone}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.pushAndRemoveUntil(
                  const BuyerHomeScreen(),
                  (route) => false,
                );
              },
              child: const Text("Go to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
