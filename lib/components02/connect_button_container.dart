import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_background/animated_background.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:azaadi_vpn_android/controller/connection_controller.dart';
import 'package:azaadi_vpn_android/core/models/services/vpn_engine.dart';

class ConnectButtonContainer1 extends StatefulWidget {
  @override
  State<ConnectButtonContainer1> createState() =>
      _ConnectButtonContainer1State();
}

class _ConnectButtonContainer1State extends State<ConnectButtonContainer1>
    with TickerProviderStateMixin {
  final connectionController = Get.put(ConnectionController());

  @override
  Widget build(BuildContext context) {
    connectionController.listenVpnState();
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.35,
      child: Obx(
        () => AnimatedBackground(
          behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
            baseColor: Colors.red,
            particleCount: connectionController.showAnimation.value ? 40 : 0,
            maxOpacity: 1,
            minOpacity: 0.5,
            spawnMaxRadius: 10,
            spawnMinSpeed: 10,
            spawnMaxSpeed: 30,
          )),
          vsync: this,
          child: Column(
            children: [
              Container(
                height: size.height * 0.28,
                width: double.infinity,
                child: GestureDetector(
                  onTap: connectionController.connectVpn,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            connectionController.vpnState.value == 'Connected'
                                ? Colors.green.withAlpha(150)
                                : connectionController.vpnState.value !=
                                        'Disconnected'
                                    ? Colors.transparent
                                    : const Color.fromARGB(255, 0, 75, 2)
                                        .withAlpha(50),
                            connectionController.vpnState.value == 'Connected'
                                ? Colors.red.withAlpha(170)
                                : connectionController.vpnState.value !=
                                        'Disconnected'
                                    ? Colors.transparent
                                    : const Color.fromARGB(255, 95, 6, 0)
                                        .withAlpha(50),
                          ],
                          stops: [
                            0.2,
                            0.8
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      shape: BoxShape.circle,
                    ),
                    child: connectionController.vpnState.value ==
                                'Disconnected' ||
                            connectionController.vpnState.value == 'Connected'
                        ? Icon(
                            connectionController.vpnState.value == 'Connected'
                                ? CupertinoIcons.moon_fill
                                : CupertinoIcons.moon,
                            size: (size.height * size.width * 0.00019),
                            color: Colors.white)
                        : LoadingAnimationWidget.hexagonDots(
                            color: Colors.red,
                            size: (size.height * size.width * 0.00024)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.025),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: 16),
                              children: [
                            TextSpan(text: 'Status: '),
                            TextSpan(
                                text: connectionController.vpnState.value ==
                                        VpnEngine.vpnDisconnected
                                    ? 'Disconnected'
                                    : connectionController.vpnState.value ==
                                            'Connected'
                                        ? 'Connected 🤠'
                                        : connectionController.vpnState.value
                                            .replaceAll("_", " "),
                                style: TextStyle(
                                    color: connectionController
                                                .vpnState.value ==
                                            'Connected'
                                        ? Color.fromARGB(255, 2, 250, 10)
                                        : connectionController.vpnState.value !=
                                                'Disconnected'
                                            ? Colors.yellow
                                            : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19))
                          ])),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
