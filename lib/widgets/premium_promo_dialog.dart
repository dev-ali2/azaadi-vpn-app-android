import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PremiumPromoDialog extends StatelessWidget {
  final TextEditingController c = TextEditingController();
  PremiumPromoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width * 0.9,
        height: size.height * 0.7,
        child: Scaffold(
          body: Container(
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Enter promo code to enable premium features',
                      style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: c,
                    decoration: InputDecoration(
                        hintText: 'Promo code',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        String code = c.text.trim();
                        final String saved = await HiveController.getPromoCode;
                        if (code == saved) {
                          final p = Get.find<PremiumController>();
                          p.isPremium.value = true;
                          HiveController.setIsPremium = true;
                          Get.back();
                          Get.back();
                          Get.snackbar(
                              duration: Duration(seconds: 10),
                              'Code valid',
                              'Enabled premium version until next restart');
                        } else {
                          Get.snackbar('Invalid Code',
                              'Given code is not valid promo code');
                        }
                      },
                      child: Text('Verify'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
