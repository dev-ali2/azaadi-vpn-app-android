import 'package:azaadi_vpn_android/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});
  final splashControler = SplashController();
  @override
  Widget build(BuildContext context) {
    splashControler.splashLogic();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: size.height,
        width: size.width,
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/splash-icon.png',
                height: size.height * 0.3,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${splashControler.messsage.value}  ',
                      style: GoogleFonts.ptSans(
                        textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      )),
                  splashControler.showLoading.value
                      ? LoadingAnimationWidget.threeArchedCircle(
                          color: Theme.of(context).colorScheme.primary,
                          size: 25)
                      : SizedBox.shrink()
                ],
              ),
              !splashControler.showLoading.value &&
                      splashControler.enableRetryButton.value
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            splashControler.splashLogic();
                          },
                          icon: Icon(Icons.replay_outlined),
                          label: Text('Retry')),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
